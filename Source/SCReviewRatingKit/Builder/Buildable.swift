import Foundation

public protocol Buildable {
  associatedtype View
  var targetView: View { get }
  func build() -> View
}

public extension Buildable {
  func build() -> View {
    return targetView
  }
}
