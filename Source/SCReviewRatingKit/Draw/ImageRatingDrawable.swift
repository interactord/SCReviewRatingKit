import UIKit

protocol ImageRatingDrawable {
	func drawRatingImage(frame: CGRect, highlighted: Bool)
	func drawHalfRatingImage(frame: CGRect)
	func drawAccurateHalfRatingImage(frame: CGRect, progress: CGFloat)
	func drawImage(frame: CGRect, image: UIImage?)
}
