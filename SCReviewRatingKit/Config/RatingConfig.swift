import Foundation

public struct RatingConfig {
  var shouldUseImage: Bool
  var filledImage: UIImage?
  var emptyImage: UIImage?
  var halfImage: UIImage?
  var tintColor: UIColor
  var borderColor: UIColor?
  var emptyStarColor: UIColor
  var borderWidth: CGFloat
  var spacing: CGFloat
  var minimumValue: UInt
  var maximumValue: UInt
  var currentValue: Float
  var allowHalfMode: Bool
  var accurateHalfMode: Bool
  var continuous: Bool

  public init() {
    self.shouldUseImage = false
    self.filledImage = nil
    self.emptyImage = nil
    self.halfImage = nil
    self.tintColor = .white
    self.minimumValue = 0
    self.maximumValue = 5
    self.currentValue = 1.2
    self.borderColor = nil
    self.emptyStarColor = .clear
    self.borderWidth = 1.0
    self.spacing = 5.0
    self.allowHalfMode = true
    self.accurateHalfMode = true
    self.continuous = true
  }
}

extension RatingConfig: Equatable {
  public static func == (lhs: RatingConfig, rhs: RatingConfig) -> Bool {
    return lhs.shouldUseImage == rhs.shouldUseImage
      && lhs.filledImage == rhs.filledImage
      && lhs.emptyImage == rhs.emptyImage
      && lhs.halfImage == rhs.halfImage
      && lhs.tintColor == rhs.tintColor
      && lhs.borderColor == rhs.borderColor
      && lhs.emptyStarColor == rhs.emptyStarColor
      && lhs.borderWidth == rhs.borderWidth
      && lhs.spacing == rhs.spacing
      && lhs.allowHalfMode == rhs.allowHalfMode
      && lhs.continuous == rhs.continuous
  }
}
