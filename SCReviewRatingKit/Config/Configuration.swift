import Foundation

protocol Configuration {
  var shouldUseImage: Bool { get set }
  var filledImage: UIImage? { get set }
  var emptyImage: UIImage? { get set }
  var halfImage: UIImage? { get set }
  var borderColor: UIColor? { get set }
  var emptyStarColor: UIColor { get set }
  var borderWidth: CGFloat { get set }
  var spacing: CGFloat { get set }
  var minimumValue: UInt { get set }
  var maximumValue: UInt { get set }
  var currentValue: Float { get set }
  var allowHalfMode: Bool { get set }
  var accurateHalfMode: Bool { get set }
  var continuous: Bool { get set }
}
