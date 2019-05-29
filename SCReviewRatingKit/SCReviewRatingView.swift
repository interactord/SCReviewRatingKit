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

extension SCReviewRatingView: Configuration {
	var shouldUseImage: Bool {
		get {
			return config.shouldUseImage
		}
		set {
			if config.shouldUseImage == newValue {
				return
			}
			config.shouldUseImage = newValue
			setNeedsDisplay()
		}
	}

	var filledImage: UIImage? {
		get {
			return config.filledImage
		}
		set {
			if config.filledImage == newValue {
				return
			}
			config.filledImage = newValue
			setNeedsDisplay()
		}
	}

	var emptyImage: UIImage? {
		get {
			return config.emptyImage
		}
		set {
			if config.emptyImage == newValue {
				return
			}
			config.emptyImage = newValue
			setNeedsDisplay()
		}
	}

	var halfImage: UIImage? {
		get {
			return  config.halfImage
		}
		set {
			if config.halfImage == newValue {
				return
			}
			config.halfImage = newValue
			setNeedsDisplay()
		}
	}

	var borderColor: UIColor? {
		get {
			return config.borderColor
		}
		set {
			if config.borderColor == newValue {
				return
			}
			config.borderColor = newValue
			setNeedsDisplay()
		}
	}

	var emptyStarColor: UIColor {
		get {
			return config.emptyStarColor
		}
		set {
			if config.emptyStarColor == newValue {
				return
			}
			config.emptyStarColor = newValue
			setNeedsDisplay()
		}
	}

	var borderWidth: CGFloat {
		get {
			return config.borderWidth
		}
		set {
			if config.borderWidth == newValue {
				return
			}
			config.borderWidth = newValue
			setNeedsDisplay()
		}
	}

	var spacing: CGFloat {
		get {
			return config.spacing
		}
		set {
			if config.spacing == newValue {
				return
			}
			config.spacing = newValue
			setNeedsDisplay()
		}
	}

	var minimumValue: UInt {
		get {
			return config.minimumValue
		}
		set {
			if config.minimumValue == newValue {
				return
			}
			config.minimumValue = newValue
			setNeedsDisplay()
		}
	}

	var maximumValue: UInt {
		get {
			return config.maximumValue
		}
		set {
			if config.maximumValue == newValue {
				return
			}
			config.maximumValue = newValue
			setNeedsDisplay()
		}
	}

	var currentValue: Float {
		get {
			return config.currentValue
		}
		set {
			if config.currentValue == newValue {
				return
			}
			config.currentValue = newValue
			setNeedsDisplay()
		}
	}

	var allowHalfMode: Bool {
		get {
			return config.allowHalfMode
		}
		set {
			if config.allowHalfMode == newValue {
				return
			}
			config.allowHalfMode = newValue
			setNeedsDisplay()
		}
	}

	var accurateHalfMode: Bool {
		get {
			return config.accurateHalfMode
		}
		set {
			if config.accurateHalfMode == newValue {
				return
			}
			config.accurateHalfMode = newValue
			setNeedsDisplay()
		}
	}

	var continuous: Bool {
		get {
			return config.continuous
		}
		set {
			if config.continuous == newValue {
				return
			}
			config.continuous = newValue
			setNeedsDisplay()
		}
	}
}
