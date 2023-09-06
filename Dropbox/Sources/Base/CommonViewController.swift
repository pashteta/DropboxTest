//
//  CommonViewController.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

#if canImport(UIKit)
import Foundation
import UIKit

open class CommonViewController: UIViewController { }

// MARK: - Keyboard handling
public extension CommonViewController {
    /// Hides keyboard when user taps outside of it
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    /// Keyboard is dismissed and editing mode ends
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
#endif
