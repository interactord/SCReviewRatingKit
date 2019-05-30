import UIKit

public class BaseControlView: UIControl {

  public var shouldBeginCompletion: (() -> Bool)?
  public var enabledTouch = true
  public var shouldBecomeFirstResponder = true

  public lazy var config: RatingConfig = {
    var config = RatingConfig(tintColor: self.tintColor)
    return config
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setDefault()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setDefault()
  }

  override public func setNeedsLayout() {
    super.setNeedsLayout()
    setNeedsDisplay()
  }

  override public var backgroundColor: UIColor? {
    didSet {
      if super.backgroundColor == nil {
        self.backgroundColor = self.isOpaque ? .white : .clear
      }
    }
  }

  override public var isEnabled: Bool {
    didSet {
      updateAppearanceForState(to: isEnabled)
      super.isEnabled = isEnabled
    }
  }

  public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if !self.isEnabled || !enabledTouch {
      return false
    }
    super.beginTracking(touch, with: event)
    if shouldBecomeFirstResponder && !isFirstResponder {
      becomeFirstResponder()
    }
    handle(touch: touch)
    return true
  }

  public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if !isEnabled || !enabledTouch {
      return false
    }
    super.continueTracking(touch, with: event)
    handle(touch: touch)
    return true
  }

  public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    if !self.isEnabled || !enabledTouch {
      return
    }
    super.endTracking(touch, with: event)
    if shouldBecomeFirstResponder && !isFirstResponder {
      becomeFirstResponder()
    }

    if let touch = touch {
      handle(touch: touch)
    }

    if !config.continuous {
      sendActions(for: .valueChanged)
    }
  }

  public override func cancelTracking(with event: UIEvent?) {
    super.cancelTracking(with: event)
    if shouldBecomeFirstResponder && isFirstResponder {
      resignFirstResponder()
    }
  }

  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer.view == self {
      return !isUserInteractionEnabled
    }
    guard let closure = shouldBeginCompletion else {
      return false
    }
    return closure()
  }

  // MARK: - First responder

  public override var canBecomeFocused: Bool {
    return shouldBecomeFirstResponder
  }

  public override var intrinsicContentSize: CGSize {
    let height: CGFloat = 44.0
    let width = config.maximumValue.toCGFloat() * height + (config.maximumValue - 1).toCGFloat() * config.spacing
    return .init(width: width, height: height)
  }

  public override var isAccessibilityElement: Bool {
    willSet {
      return self.isAccessibilityElement = true
    }
  }

  public override var accessibilityLabel: String? {
    willSet {
      accessibilityLabel = NSLocalizedString("rating", comment: "Accessibility label for star rating control.")
    }
  }

  public override var accessibilityTraits: UIAccessibilityTraits {
    willSet {
      accessibilityTraits = UIAccessibilityTraits(
        rawValue: super.accessibilityTraits.rawValue | UIAccessibilityTraits.adjustable.rawValue
      )
    }
  }

  public override var accessibilityValue: String? {
    willSet {
      accessibilityValue = config.currentValue.description
    }
  }

  public override func accessibilityActivate() -> Bool {
    return true
  }

  public override func accessibilityIncrement() {
    let value = config.currentValue + (config.allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: value, sendAction: true)
  }

  public override func accessibilityDecrement() {
    let value = config.currentValue - (config.allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: value, sendAction: true)
  }

  public override func draw(_ rect: CGRect) {
    guard let backgroundColor = self.backgroundColor else {
      return
    }
    startDraw(rect, backgroundColor: backgroundColor)
  }

  func changedValueAndChangedAction(to value: Float, sendAction: Bool) {
		if config.currentValue == value
				 && value < config.minimumValue.toFloat()
				 && value > config.maximumValue.toFloat() {
			return
		}
		config.currentValue = value
		if sendAction {
			sendActions(for: .valueChanged)
		}
		self.setNeedsDisplay()
  }

  public func startDraw(_ rect: CGRect, backgroundColor: UIColor) {
  }

}

extension BaseControlView {

  func setDefault() {
    isExclusiveTouch = true
    updateAppearanceForState(to: self.isEnabled)
  }

  private func updateAppearanceForState(to enabled: Bool) {
    alpha = enabled ? 1.0 : 0.5
  }

  func handle(touch: UITouch) {
    let cellWidth = bounds.size.width / config.maximumValue.toCGFloat()
    let location = touch.location(in: self)
    var value: Float = (location.x / cellWidth).toFloat()

    if config.allowHalfMode {
      if !config.allowHalfMode {
        if (value + 0.5) < ceilf(value) {
          value = floor(value)
        } else {
          value = ceilf(value)
        }
      }
    } else {
      value = ceilf(value)
    }

    changedValueAndChangedAction(to: value, sendAction: config.continuous)
  }
}
