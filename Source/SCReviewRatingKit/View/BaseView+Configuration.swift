import UIKit

extension BaseControlView: Configuration {

  public var shouldUseImage: Bool {
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

  public var filledImage: UIImage? {
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

  public var emptyImage: UIImage? {
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

  public var halfImage: UIImage? {
    get {
      return config.halfImage
    }
    set {
      if config.halfImage == newValue {
        return
      }
      config.halfImage = newValue
      setNeedsDisplay()
    }
  }

  public var borderColor: UIColor? {
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

  public var emptyStarColor: UIColor {
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

  public var borderWidth: CGFloat {
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

  public var spacing: CGFloat {
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

  public var minimumValue: UInt {
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

  public var maximumValue: UInt {
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

  public var currentValue: Float {
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

  public var allowHalfMode: Bool {
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

  public var accurateHalfMode: Bool {
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

  public var continuous: Bool {
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
