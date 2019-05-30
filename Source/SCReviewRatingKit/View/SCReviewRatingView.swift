import UIKit

public class SCReviewRatingView: BaseControlView {
	public override func startDraw(_ rect: CGRect, backgroundColor: UIColor) {
		super.startDraw(rect, backgroundColor: backgroundColor)
		let shapeRatingDrawing = ShapeRatingDrawing(shape: StarShape(), config: config)
		let imageRatingDrawing = ImageRatingDrawing(config: config)
		let ratingDrawing = RatingDrawing(shapeRatingDrawer: shapeRatingDrawing, imageRatingDrawer: imageRatingDrawing, shouldUseImage: config.shouldUseImage)
		let drawing = Drawing(config: config, backgroundColor: backgroundColor, ratingDrawing: ratingDrawing)
		drawing.drawRating(frame: rect)
	}
}

extension SCReviewRatingView {
	public override var tintColor: UIColor! {
		get {
			return super.tintColor
		}
		set {
			if super.tintColor == newValue {
				return
			}
			super.tintColor = newValue
			config.tintColor = newValue
			setNeedsDisplay()
		}
	}
}
