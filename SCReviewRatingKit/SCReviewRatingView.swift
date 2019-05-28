import UIKit

public protocol configable {
  var minimumValue: CGFloat { get set }
  var maximumValue: UInt { get set }
  var value: Float { get set }
  var spacing: CGFloat { get set }
  var allowHalfMode: Bool { get set }
  var accurateHalfMode: Bool { get set }
  var emptyImage: UIImage? { get set }
  var halfImage: UIImage? { get set }
  var filledImage: UIImage? { get set }
  var borderColor: UIColor? { get set }
  var emptyStarColor: UIColor { get set }
  var shouldUseImage: Bool { get }
  var enabledTouch: Bool { get set }
  var shouldBecomeFirstResponder: Bool { get set }
  var shouldBegingCompletion: (() -> Bool)? { get }
}

public class SCReviewRatingView: UIControl {

  private var _minimumValue: CGFloat = 0
  private var _maximumValue: UInt = 5
  private var _value: Float = 0
  private var _spacing: CGFloat = 5.0
  private var _continuous: Bool = true
  private var _borderWidth: CGFloat = 1.0
  private var _emptyStarColor = UIColor.clear
  private var _allowHalfMode: Bool = true
  private var _accurateHalfMode: Bool = true
  private var _emptyImage: UIImage?
  private var _halfImage: UIImage?
  private var _filledImage: UIImage?
  private var _borderColor: UIColor?

  private var _enabledTouch: Bool = true
  private var _shouldBecomeFirstResponder: Bool = true
  private var _shouldBegingCompletion: (() -> Bool)?

  private lazy var _starDrawer: StarDrawer = {
    return StarDrawer(
      shouldUseImage: false,
      filledImage: _filledImage,
      emptyImage: _emptyImage,
      halfImage: _halfImage,
      borderColor: _borderColor,
      emptyStarColor: _emptyStarColor,
      borderWidth: _borderWidth
    )
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
    guard
      let context = UIGraphicsGetCurrentContext(),
      let backgrouncColor = self.backgroundColor
      else { return }

    context.setFillColor(backgrouncColor.cgColor)
    context.fill(rect)

    let availableWidth = rect.size.width - (_spacing * (_maximumValue.toCGFloat() - 1)) - 2
    let cellWidth = availableWidth / _maximumValue.toCGFloat()
    var side = cellWidth <= rect.size.height ? cellWidth : rect.size.height
    side = shouldUseImage ? side : side - _borderWidth

    for index in 0..<_maximumValue {
      let center = getDrawCenter(rect, cellWidth: cellWidth, index: index)
      let frame = getDrawFrame(center, side: side)
      let highlighted = Float(index + 1) <= ceilf(_value)

      if _allowHalfMode && highlighted && Float(index + 1) > _value {
        if _accurateHalfMode {
          _starDrawer.drawAccurateStar(withFrame: frame, tintColor: tintColor, progress: _value.toCGFloat() - index.toCGFloat())
          return
        }
        _starDrawer.drawHalfStar(withFrame: frame, tintColor: tintColor)
        return
      }

      _starDrawer.drawStar(withFrame: frame, tintColor: tintColor, highlighted: highlighted)
    }
  }

  public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if !self.isEnabled || !_enabledTouch {
      return false
    }
    super.beginTracking(touch, with: event)
    if _shouldBecomeFirstResponder && !isFirstResponder {
      becomeFirstResponder()
    }
    handle(touch: touch)
    return true
  }

  public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    if !isEnabled || !_enabledTouch {
      return false
    }
    super.continueTracking(touch, with: event)
    handle(touch: touch)
    return true
  }

  public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    if !self.isEnabled || !_enabledTouch {
      return
    }
    super.endTracking(touch, with: event)
    if _shouldBecomeFirstResponder && !isFirstResponder {
      becomeFirstResponder()
    }

    if let touch = touch {
      handle(touch: touch)
    }

    if !_continuous {
      sendActions(for: .valueChanged)
    }
  }

  public override func cancelTracking(with event: UIEvent?) {
    super.cancelTracking(with: event)
    if _shouldBecomeFirstResponder && isFirstResponder {
      resignFirstResponder()
    }
  }

  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer.view == self {
      return !isUserInteractionEnabled
    }
    guard let closure = _shouldBegingCompletion else {
      return false
    }
    return closure()
  }

  // MARK: - First responder

  public override var canBecomeFocused: Bool {
    return _shouldBecomeFirstResponder
  }

  public override var intrinsicContentSize: CGSize {
    let height: CGFloat = 44.0
    let width = _maximumValue.toCGFloat() * height + (_maximumValue - 1).toCGFloat() * _spacing
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
      accessibilityValue = self.value.description
    }
  }

  public override func accessibilityActivate() -> Bool {
    return true
  }

  public override func accessibilityIncrement() {
    let aValue = value + (allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: aValue, sendAction: true)
  }

  public override func accessibilityDecrement() {
    let aValue = value - (allowHalfMode ? 0.5 : 1.0)
    changedValueAndChangedAction(to: aValue, sendAction: true)
  }
}

extension SCReviewRatingView: configable {
  public var emptyStarColor: UIColor {
    get {
      return _emptyStarColor
    }
    set {
      if _emptyStarColor == newValue { return }
      _emptyStarColor = newValue
    }
  }

  public var shouldBegingCompletion: (() -> Bool)? {
    return _shouldBegingCompletion
  }

  public var minimumValue: CGFloat {
    get {
      return max(_minimumValue, 0)
    }
    set {
      if _minimumValue == newValue { return }
      _minimumValue = newValue
      setNeedsDisplay()
    }
  }

  public var maximumValue: UInt {
    get {
      return UInt(max(_minimumValue, _maximumValue.toCGFloat()))
    }
    set {
      if _maximumValue == newValue { return }
      setNeedsDisplay()
      invalidateIntrinsicContentSize()
    }
  }

  public var value: Float {
    get {
      return min(max(_value, _minimumValue.toFloat()), _maximumValue.toFloat())
    }
    set {
      changedValueAndChangedAction(to: newValue, sendAction: false)
    }
  }

  public var spacing: CGFloat {
    get {
      return _spacing
    }
    set {
      _spacing = max(newValue, 0)
      setNeedsDisplay()
    }
  }

  public var allowHalfMode: Bool {
    get {
      return _allowHalfMode
    }
    set {
      if _allowHalfMode == newValue { return }
      _allowHalfMode = newValue
      setNeedsDisplay()
    }
  }

  public var accurateHalfMode: Bool {
    get {
      return _accurateHalfMode
    }
    set {
      if _accurateHalfMode == newValue { return }
      _accurateHalfMode = newValue
      setNeedsDisplay()
    }
  }

  public var emptyImage: UIImage? {
    get {
      return _emptyImage
    }
    set {
      if _emptyImage == newValue { return }
      _emptyImage = newValue
      setNeedsDisplay()
    }
  }

  public var halfImage: UIImage? {
    get {
      return _halfImage
    }
    set {
      if _halfImage == newValue { return }
      _halfImage = newValue
      setNeedsDisplay()
    }
  }

  public var filledImage: UIImage? {
    get {
      return _filledImage
    }
    set {
      if _filledImage == newValue { return }
      _filledImage = newValue
      setNeedsDisplay()
    }
  }

  public var borderColor: UIColor? {
    get {
      if _borderColor == nil {
        return tintColor
      }
      return _borderColor
    }
    set {
      if _borderColor == newValue { return }
      _borderColor = newValue
      setNeedsDisplay()
    }
  }

  public var shouldUseImage: Bool {
    return emptyImage != nil && filledImage != nil
  }

  public var enabledTouch: Bool {
    get {
      return _enabledTouch
    }
    set {
      if _enabledTouch == newValue { return }
      _enabledTouch = newValue
    }
  }

  public var shouldBecomeFirstResponder: Bool {
    get {
      return _shouldBecomeFirstResponder
    }
    set {
      if _shouldBecomeFirstResponder == newValue { return }
      _shouldBecomeFirstResponder = newValue
    }
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
    if _value == aValue && aValue < _minimumValue.toFloat() && aValue > maximumValue.toFloat() {
      return
    }
    _value = aValue
    if sendAction {
      sendActions(for: .valueChanged)
    }
    self.setNeedsDisplay()
    didChangeValue(forKey: "value")
  }

  private func getDrawCenter(_ rect: CGRect, cellWidth: CGFloat, index: UInt) -> CGPoint {
    let cgFloatIndex = CGFloat(index)
    return .init(
      x: (cellWidth * cgFloatIndex) + cellWidth / 2 + _spacing + 1,
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

    let cellWidth = bounds.size.width / _maximumValue.toCGFloat()
    let location = touch.location(in: self)
    var value: Float = (location.x / cellWidth).toFloat()

    if _allowHalfMode {
      if !_accurateHalfMode {
        if (value + 0.5) < ceilf(value) {
          value = floor(value)
        } else {
          value = ceilf(value)
        }
      }
    } else {
      value = ceilf(value)
    }

    changedValueAndChangedAction(to: value, sendAction: _continuous)
  }

}
