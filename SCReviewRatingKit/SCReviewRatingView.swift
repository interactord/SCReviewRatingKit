import UIKit

public class SCReviewRatingView: UIControl {

  var enabledTouch: Bool = true
  var shouldBecomeFirstResponder: Bool = true
  var shouldBeginCompletion: (() -> Bool)?

  lazy var config: RatingConfig = {
    var config = RatingConfig()
    config.tintColor = self.tintColor
    return config
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setDefault()
  }

  required init?(coder aDecoder: NSCoder) {
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

  override public func draw(_ rect: CGRect) {
    guard let backgroundColor = self.backgroundColor else {
      return
    }

    let shapeRatingDrawing = ShapeRatingDrawing(shape: StarShape(), config: config)
    let imageRatingDrawing = ImageRatingDrawing(config: config)
    let ratingDrawing = RatingDrawing(shapeRatingDrawer: shapeRatingDrawing, imageRatingDrawer: imageRatingDrawing, shouldUseImage: config.shouldUseImage)
    let drawing = Drawing(config: config, backgroundColor: backgroundColor, ratingDrawing: ratingDrawing)
    drawing.drawRating(frame: rect)
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
    let aValue = config.currentValue + (config.allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: aValue, sendAction: true)
  }

  public override func accessibilityDecrement() {
    let aValue = config.currentValue - (config.allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: aValue, sendAction: true)
  }
}

extension SCReviewRatingView {

  func setDefault() {
    isExclusiveTouch = true
    setBackgroundColor()
    updateAppearanceForState(to: self.isEnabled)
  }

  func setBackgroundColor() {
    backgroundColor = isOpaque ? .white : .clear
  }
}

extension SCReviewRatingView {
  private func updateAppearanceForState(to enabled: Bool) {
    alpha = enabled ? 1.0 : 0.5
  }

  private func changedValueAndChangedAction(to aValue: Float, sendAction: Bool) {
    willChangeValue(forKey: "value")
    if config.currentValue == aValue && aValue < config.minimumValue.toFloat() && aValue > config.maximumValue.toFloat() {
      return
    }
    config.currentValue = aValue
    if sendAction {
      sendActions(for: .valueChanged)
    }
    self.setNeedsDisplay()
    didChangeValue(forKey: "value")
  }

  private func getDrawCenter(_ rect: CGRect, cellWidth: CGFloat, index: UInt) -> CGPoint {
    let cgFloatIndex = CGFloat(index)
    return .init(
      x: (cellWidth * cgFloatIndex) + cellWidth / 2 + config.spacing + 1,
      y: rect.size.height / 2
    )
  }

  private func getDrawFrame(_ center: CGPoint, side: CGFloat) -> CGRect {
    return .init(
      x: center.x - side / 2,
      y: center.y - side / 2,
      width: side,
      height: side
    )
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
