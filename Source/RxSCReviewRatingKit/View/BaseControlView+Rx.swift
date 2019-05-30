import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: BaseControlView {

  public var currentValue: ControlProperty<Float> {
    return base.rx.controlProperty(
      editingEvents: .valueChanged,
      getter: { base in
        base.config.currentValue
      }, setter: { base, currentValue in
        base.config.currentValue = currentValue
      })
  }

  public var changedCurrentValue: Binder<Float> {
    return Binder(self.base) { base, result in
        base.currentValue = result
    }
  }
}
