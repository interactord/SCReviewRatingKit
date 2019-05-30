import UIKit

struct RatingDrawing {
  let shapeRatingDrawer: ShapeRatingDrawable
  let imageRatingDrawer: ImageRatingDrawable
  let shouldUseImage: Bool

  init(
    shapeRatingDrawer: ShapeRatingDrawable,
    imageRatingDrawer: ImageRatingDrawable,
    shouldUseImage: Bool
  ) {
    self.shapeRatingDrawer = shapeRatingDrawer
    self.imageRatingDrawer = imageRatingDrawer
    self.shouldUseImage = shouldUseImage
  }
}

extension RatingDrawing: RatingDrawable {
  func drawRating(frame: CGRect, highlighted: Bool) {
    shouldUseImage
      ? imageRatingDrawer.drawRatingImage(frame: frame, highlighted: highlighted)
      : shapeRatingDrawer.drawRatingShape(frame: frame, highlighted: highlighted)
  }

  func drawHalfRating(frame: CGRect) {
    shouldUseImage
      ? imageRatingDrawer.drawHalfRatingImage(frame: frame, shapeRatingDrawer: shapeRatingDrawer)
      : shapeRatingDrawer.drawHalfRatingShape(frame: frame)
  }

  func drawAccurateRating(frame: CGRect, progress: CGFloat) {
    shouldUseImage
      ? imageRatingDrawer.drawAccurateHalfRatingImage(frame: frame, progress: progress)
      : shapeRatingDrawer.drawAccurateHalfRatingShape(frame: frame, progress: progress)
  }
}
