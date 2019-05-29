import UIKit

struct ShapeRatingDrawing {
  let shape: Shadable
  let tintColor: UIColor
  let emptyStarColor: UIColor
  let borderWidth: CGFloat
  var borderColor: UIColor?

  init(
    shape: Shadable,
    tintColor: UIColor,
    emptyStarColor: UIColor = .clear,
    borderWith: CGFloat,
    borderColor: UIColor? = nil
  ) {
    self.shape = shape
    self.tintColor = tintColor
    self.emptyStarColor = emptyStarColor
    self.borderWidth = borderWith
    self.borderColor = borderColor
  }

  init(shape: Shadable, config: RatingConfig) {
    self.shape = shape
    self.tintColor = config.tintColor
    self.emptyStarColor = config.emptyStarColor
    self.borderWidth = config.borderWidth
    self.borderColor = config.borderColor
  }
}

extension ShapeRatingDrawing: ShapeRatingDrawable {
  func drawRatingShape(frame: CGRect, highlighted: Bool) {
    let progress: CGFloat = highlighted ? 1.0 : 0.0
    drawAccurateHalfRatingShape(frame: frame, progress: progress)
  }

  func drawHalfRatingShape(frame: CGRect) {
    drawAccurateHalfRatingShape(frame: frame, progress: 0.5)
  }

  func drawAccurateHalfRatingShape(frame: CGRect, progress: CGFloat) {
    let starShapePath = shape.makeShape(frame: frame)
    let frameWidth = frame.size.width
    let rightRectOfStar = CGRect(
      x: frame.origin.x + progress * frameWidth,
      y: frame.origin.y,
      width: frameWidth - progress * frameWidth,
      height: frame.size.height
    )
    let clipPath = UIBezierPath(rect: CGRect.infinite)
    clipPath.append(UIBezierPath(rect: rightRectOfStar))
    clipPath.usesEvenOddFillRule = true
    emptyStarColor.setFill()
    starShapePath.fill()

    UIGraphicsGetCurrentContext()?.saveGState()
    clipPath.addClip()
    tintColor.setFill()
    starShapePath.fill()
    UIGraphicsGetCurrentContext()?.restoreGState()

    borderColor?.setStroke()
    starShapePath.lineWidth = borderWidth
    starShapePath.stroke()
  }
}
