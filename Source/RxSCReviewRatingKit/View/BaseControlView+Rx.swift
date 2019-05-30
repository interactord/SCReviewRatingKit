import UIKit
import RxSwift
import RxCocoa
import SCReviewRatingKit

public extension Reactive where Base: BaseControlView {

  var currentValue: ControlProperty<Float> {
    return base.rx.controlProperty(
      editingEvents: .valueChanged,
      getter: { base in
        base.currentValue
      }, setter: { base, currentValue in
        base.currentValue = currentValue
      })
  }

  var changedCurrentValue: Binder<Float> {
    return Binder(self.base) { base, result in
        base.currentValue = result
    }
  }
}
