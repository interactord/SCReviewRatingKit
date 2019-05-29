import UIKit

struct Drawing {
  private let config: RatingConfig
  private let backgroundColor: UIColor
  private let ratingDrawing: RatingDrawable

  init(
    config: RatingConfig,
    backgroundColor: UIColor,
    ratingDrawing: RatingDrawable
  ) {
    self.config = config
    self.backgroundColor = backgroundColor
    self.ratingDrawing = ratingDrawing
  }
}

extension Drawing: Drawable {

  func drawRating(frame: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }
    context.setFillColor(backgroundColor.cgColor)
    context.fill(frame)

    let availableWidth = frame.size.width - (config.spacing * (config.maximumValue.toCGFloat() - 1)) - 2
    let cellWidth = availableWidth / config.maximumValue.toCGFloat()
    var side = cellWidth <= frame.size.height ? cellWidth : frame.size.height
    side = config.shouldUseImage ? side : side - config.borderWidth

    for index in 0..<config.maximumValue {
      let center = getDrawCenter(frame, cellWidth: cellWidth, index: index)
      let aFrame = getDrawFrame(center, side: side)
      let highlighted = Float(index + 1) <= ceilf(config.currentValue)

      if config.allowHalfMode && highlighted && Float(index + 1) > config.currentValue {
        if config.accurateHalfMode {
          let progress = config.currentValue.toCGFloat() - index.toCGFloat()
          ratingDrawing.drawAccurateRating(frame: aFrame, progress: progress)
          return
        }
        ratingDrawing.drawHalfRating(frame: aFrame)
        return
      }

      ratingDrawing.drawRating(frame: aFrame, highlighted: highlighted)
    }
  }
}

extension Drawing {
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
}
