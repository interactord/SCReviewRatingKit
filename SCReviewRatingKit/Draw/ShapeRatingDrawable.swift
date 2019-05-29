import UIKit

protocol ShapeRatingDrawable {
	func drawRatingShape(frame: CGRect, highlighted: Bool)
	func drawHalfRatingShape(frame: CGRect)
	func drawAccurateHalfRatingShape(frame: CGRect, progress: CGFloat)
}
