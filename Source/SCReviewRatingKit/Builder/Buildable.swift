import Foundation

protocol Buildable {
  associatedtype View
  var targetView: View { get }
  func build() -> View
}

extension Buildable {
  func build() -> View {
    return targetView
  }
}
