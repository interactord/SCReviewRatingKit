import Foundation

protocol RatingDrawable {
	func drawRating(frame: CGRect, highlighted: Bool)
	func drawHalfRating(frame: CGRect)
	func drawAccurateRating(frame: CGRect, progress: CGFloat)
}
