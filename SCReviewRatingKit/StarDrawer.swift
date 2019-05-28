//
//  StarDraw.swift
//  SCReviewRatingKit
//
//  Created by Scott Moon on 28/05/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

struct StarDrawer {
  /// Dividing Draw to Image or Shape

  var shouldUseImage: Bool
  var filledImage: UIImage?
  var emptyImage: UIImage?
  var halfImage: UIImage?
  var borderColor: UIColor?
  var emptyStarColor: UIColor
  var borderWidth: CGFloat

  func drawStar(withFrame frame: CGRect, tintColor: UIColor, highlighted: Bool) {
    shouldUseImage
      ? drawStarImage(withFrame: frame, tintColor: tintColor, highlighted: highlighted)
      : drawStarShape(withFrame: frame, tintColor: tintColor, highlighted: highlighted)
  }

  func drawHalfStar(withFrame frame: CGRect, tintColor: UIColor) {
    shouldUseImage
      ? drawHalfStarImage(withFrame: frame, tintColor: tintColor)
      : drawHalfStarShape(withFrame: frame, tintColor: tintColor)
  }

  func drawAccurateStar(withFrame frame: CGRect, tintColor: UIColor, progress: CGFloat) {
    shouldUseImage
      ? drawAccurateHalfStarImage(withFrame: frame, tintColor: tintColor, progress: progress)
      : drawAccuratedHalfStarShape(withFrame: frame, tintColor: tintColor, progress: progress)
  }

  /// Image based Draw

  func drawStarImage(withFrame frame: CGRect, tintColor: UIColor, highlighted: Bool) {
    let image = highlighted ? self.filledImage : self.emptyImage
    drawImage(withImage: image, frame: frame, tintColor: tintColor)
  }

  func drawHalfStarImage(withFrame frame: CGRect, tintColor: UIColor) {
    drawAccuratedHalfStarShape(withFrame: frame, tintColor: tintColor, progress: 0.0)
  }

  func drawAccurateHalfStarImage(withFrame frame: CGRect, tintColor: UIColor, progress: CGFloat) {
    var image = halfImage
    var tempFrame = frame
    if image == nil {
      /// outline
      drawStarImage(withFrame: frame, tintColor: tintColor, highlighted: false)

      guard
        let filledImage = filledImage,
        let filledCGImage = filledImage.cgImage
        else { return }

      let imageFrame = CGRect(x: 0, y: 0, width: filledImage.size.width * filledImage.scale * progress, height: filledImage.size.height * filledImage.scale)
      tempFrame.size.width *= progress

      let imageRef = filledCGImage.cropping(to: imageFrame)
      guard let cropedImage = imageRef else {
        return
      }

      let halfImage = UIImage(cgImage: cropedImage, scale: filledImage.scale, orientation: filledImage.imageOrientation)
      image = halfImage.withRenderingMode(filledImage.renderingMode)
    }

    drawImage(withImage: image, frame: frame, tintColor: tintColor)
  }

  func drawImage(withImage image: UIImage?, frame: CGRect, tintColor: UIColor) {
    if image?.renderingMode == .alwaysTemplate {
      tintColor.setFill()
    }
    image?.draw(in: frame)
  }

  /// Path base Draw

  func drawStarShape(withFrame frame: CGRect, tintColor: UIColor, highlighted: Bool) {
    let progress: CGFloat = highlighted ? 1.0 : 0.0
    drawAccuratedHalfStarShape(withFrame: frame, tintColor: tintColor, progress: progress)
  }

  private func drawHalfStarShape(withFrame frame: CGRect, tintColor: UIColor) {
    drawAccuratedHalfStarShape(withFrame: frame, tintColor: tintColor, progress: 0.5)
  }

  func drawAccuratedHalfStarShape(withFrame frame: CGRect, tintColor: UIColor, progress: CGFloat) {
    let starShapPath = makeStarShape(to: frame)
    let frameWidth = frame.size.width
    let rightRectOfStar = CGRect(
      x: frame.origin.x + progress * frameWidth,
      y: frame.origin.y,
      width: frameWidth - progress * frameWidth,
      height: frame.size.height
    )
    let clipPath = UIBezierPath(rect: CGRect.infinite)
    clipPath.append(UIBezierPath(rect: rightRectOfStar))
    clipPath.usesEvenOddFillRule = true
    self.emptyStarColor.setFill()
    starShapPath.fill()

    UIGraphicsGetCurrentContext()?.saveGState()
    clipPath.addClip()
    tintColor.setFill()
    starShapPath.fill()
    UIGraphicsGetCurrentContext()?.restoreGState()

    borderColor?.setStroke()
    starShapPath.lineWidth = borderWidth
    starShapPath.stroke()
  }

  func makeStarShape(to frame: CGRect) -> UIBezierPath {
    let starShapPath = UIBezierPath()
    starShapPath.move(to: .init(x: frame.minX + 0.627_23 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.500_00 * frame.width, y: frame.minY + 0.025_00 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.372_92 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.025_00 * frame.width, y: frame.minY + 0.391_12 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.305_04 * frame.width, y: frame.minY + 0.629_08 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.206_42 * frame.width, y: frame.minY + 0.975_00 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.500_00 * frame.width, y: frame.minY + 0.782_65 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.793_58 * frame.width, y: frame.minY + 0.975_00 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.695_01 * frame.width, y: frame.minY + 0.629_08 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.975_00 * frame.width, y: frame.minY + 0.391_12 * frame.height))
    starShapPath.addLine(to: .init(x: frame.minX + 0.627_23 * frame.width, y: frame.minY + 0.373_09 * frame.height))
    starShapPath.close()
    starShapPath.miterLimit = 4
    return starShapPath
  }
}
