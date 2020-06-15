//
//  Extensions.swift
//  MyProject
//
//  Created by Dev on 05.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


//MARK: Reactive/UIActivityIndicatorView
#if os(iOS) || os(tvOS)

extension Reactive where Base: UIActivityIndicatorView {

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { activityIndicator, active in
            if active {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

}

#endif

#if os(iOS) || os(tvOS)

extension Reactive where Base: UISegmentedControl {
    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var selectedSegmentIndex: ControlProperty<Int> {
        return value
    }

    /// Reactive wrapper for `selectedSegmentIndex` property.
    public var value: ControlProperty<Int> {
        return base.rx.controlProperty(editingEvents: .valueChanged, getter: { segmentedControl in
            segmentedControl.selectedSegmentIndex
        }, setter: { segmentedControl, value in
            segmentedControl.selectedSegmentIndex = value
        })
    }

    /// Reactive wrapper for `setEnabled(_:forSegmentAt:)`
    public func enabledForSegment(at index: Int) -> Binder<Bool> {
        return Binder(self.base) { segmentedControl, segmentEnabled -> Void in
            segmentedControl.setEnabled(segmentEnabled, forSegmentAt: index)
        }
    }

    /// Reactive wrapper for `setTitle(_:forSegmentAt:)`
    public func titleForSegment(at index: Int) -> Binder<String?> {
        return Binder(self.base) { segmentedControl, title -> Void in
            segmentedControl.setTitle(title, forSegmentAt: index)
        }
    }

    /// Reactive wrapper for `setImage(_:forSegmentAt:)`
    public func imageForSegment(at index: Int) -> Binder<UIImage?> {
        return Binder(self.base) { segmentedControl, image -> Void in
            segmentedControl.setImage(image, forSegmentAt: index)
        }
    }

}

#endif

extension Reactive where Base: UISwitch {

    /// Reactive wrapper for `isOn` property.
    public var isOn: ControlProperty<Bool> {
        return value
    }

    /// Reactive wrapper for `isOn` property.
    ///
    /// ⚠️ Versions prior to iOS 10.2 were leaking `UISwitch`'s, so on those versions
    /// underlying observable sequence won't complete when nothing holds a strong reference
    /// to `UISwitch`.
    public var value: ControlProperty<Bool> {
        return base.rx.controlProperty(editingEvents: .valueChanged,  getter: { uiSwitch in
                       uiSwitch.isOn
                   }, setter: { uiSwitch, value in
                       uiSwitch.isOn = value
                   }
        )
    }

}

// MARK: UIViewController
extension UIViewController {

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: UIAlertController

extension UIAlertController {

struct AlertAction {
    var title: String?
    var style: UIAlertAction.Style

    static func action(title: String?, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}

static func present(
    in viewController: UIViewController,
    title: String?,
    message: String?,
    style: UIAlertController.Style,
    actions: [AlertAction])
    -> Observable<Int>
{
    return Observable.create { observer in
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        actions.enumerated().forEach { index, action in
            let action = UIAlertAction(title: action.title, style: action.style) { _ in
                observer.onNext(index)
                observer.onCompleted()
            }
            alertController.addAction(action)
        }

        viewController.present(alertController, animated: true, completion: nil)
        return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}

// MARK: UIStoryboard
extension UIStoryboard {
    func create<T: UIViewController>(with storyboardId: String, type: T.Type) -> T {
        let controller: T = self.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
}

// MARK Reactive/UIButton
extension Reactive where Base: UIButton {

    /// Reactive wrapper for `setTitle(_:for:)`
    public func title(for controlState: UIControl.State = []) -> Binder<String?> {
        return Binder(self.base) { button, title -> Void in
            button.setTitle(title, for: controlState)
        }
    }

    /// Reactive wrapper for `setImage(_:for:)`
    public func image(for controlState: UIControl.State = []) -> Binder<UIImage?> {
        return Binder(self.base) { button, image -> Void in
            button.setImage(image, for: controlState)
        }
    }

    /// Reactive wrapper for `setBackgroundImage(_:for:)`
    public func backgroundImage(for controlState: UIControl.State = []) -> Binder<UIImage?> {
        return Binder(self.base) { button, image -> Void in
            button.setBackgroundImage(image, for: controlState)
        }
    }

}

