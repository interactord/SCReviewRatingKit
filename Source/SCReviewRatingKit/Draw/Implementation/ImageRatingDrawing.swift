import UIKit

struct ImageRatingDrawing {
  private let tintColor: UIColor
  private var halfImage: UIImage?
  private var filledImage: UIImage?
  private var emptyImage: UIImage?

  init(
    tintColor: UIColor,
    halfImage: UIImage? = nil,
    filledImage: UIImage? = nil,
    emptyImage: UIImage? = nil
  ) {
    self.tintColor = tintColor
    self.halfImage = halfImage
    self.filledImage = filledImage
    self.emptyImage = emptyImage
  }

  init(config: RatingConfig) {
    self.tintColor = config.tintColor
    self.halfImage = config.halfImage
    self.filledImage = config.filledImage
    self.emptyImage = config.emptyImage
  }
}

extension ImageRatingDrawing: ImageRatingDrawable {

  func drawImage(frame: CGRect, image: UIImage?) {
    if image?.renderingMode == .alwaysTemplate {
      tintColor.setFill()
    }
    image?.draw(in: frame)
  }

  func drawRatingImage(frame: CGRect, highlighted: Bool) {
    let image = highlighted ? filledImage : emptyImage
    drawImage(frame: frame, image: image)
  }

  func drawHalfRatingImage(frame: CGRect) {
    drawAccurateHalfRatingImage(frame: frame, progress: 0.5)
  }

  func drawAccurateHalfRatingImage(frame: CGRect, progress: CGFloat) {
    var image = halfImage
    var tempFrame = frame

    if image != nil {
      return drawImage(frame: frame, image: image)
    }

    /// outline
    drawRatingImage(frame: frame, highlighted: false)

    guard
      let filledImage = filledImage,
      let filledCGImage = filledImage.cgImage
      else { return }

    let imageFrame = CGRect(x: 0, y: 0, width: filledImage.size.width * filledImage.scale * progress, height: filledImage.size.height * filledImage.scale)
    tempFrame.size.width *= progress

    let imageRef = filledCGImage.cropping(to: imageFrame)
    guard let croppedImage = imageRef else {
      return
    }

    let halfImage = UIImage(cgImage: croppedImage, scale: filledImage.scale, orientation: filledImage.imageOrientation)
    image = halfImage.withRenderingMode(filledImage.renderingMode)

    return drawImage(frame: frame, image: image)
  }

}
