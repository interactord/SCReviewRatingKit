import UIKit

public struct RatingStarBuilder: Buildable {
  public var targetView: SCReviewRatingView

  public init() {
    targetView = SCReviewRatingView(frame: .zero)
  }
}

public extension RatingStarBuilder {

  func setShoudUseImage(_ value: Bool) -> RatingStarBuilder {
    targetView.shouldUseImage = value
    return self
  }

  func setImage(filledImage: UIImage? = nil, halfImage: UIImage? = nil, emptyImage: UIImage? = nil) -> RatingStarBuilder {
    targetView.filledImage = filledImage
    targetView.halfImage = halfImage
    targetView.emptyImage = emptyImage
    targetView.shouldUseImage = true
    return self
  }

  func setBackgroundColor(_ color: UIColor) -> RatingStarBuilder {
    targetView.backgroundColor = color
    return self
  }

  func setColor(tintColor: UIColor, borderColor: UIColor? = nil, emptyStarColor: UIColor = .clear) -> RatingStarBuilder {
    targetView.tintColor = tintColor
    targetView.emptyStarColor = emptyStarColor
    targetView.borderColor = borderColor == nil ? tintColor : borderColor
    return self
  }

  func setBorderWidth(_ width: CGFloat) -> RatingStarBuilder {
    targetView.borderWidth = width
    return self
  }

  func setSpacing(_ spacing: CGFloat) -> RatingStarBuilder {
    targetView.spacing = spacing
    return self
  }

  func setValue(currentValue: Float, minimumValue: UInt = 0, maximumValue: UInt = 5) -> RatingStarBuilder {
    targetView.currentValue = currentValue
    targetView.minimumValue = minimumValue
    targetView.maximumValue = maximumValue
    return self
  }

  func setMode(allowHalfMode: Bool, accuratedHalfMode: Bool) -> RatingStarBuilder {
    targetView.allowHalfMode = allowHalfMode
    targetView.accurateHalfMode = accuratedHalfMode
    return self
  }

  func setContinuous(_ continuous: Bool) -> RatingStarBuilder {
    targetView.continuous = continuous
    return self
  }

  func setTouchEnabled(_ enabled: Bool) -> RatingStarBuilder {
    targetView.isEnabled = enabled
    return self
  }

  func setWidthAnchor(_ width: CGFloat) -> RatingStarBuilder {
    targetView.translatesAutoresizingMaskIntoConstraints = false
    targetView.widthAnchor.constraint(equalToConstant: width).isActive = true
    return self
  }

  func setHeigthAnchor(_ height: CGFloat) -> RatingStarBuilder {
    targetView.translatesAutoresizingMaskIntoConstraints = false
    targetView.heightAnchor.constraint(equalToConstant: height).isActive = true
    return self
}
}
