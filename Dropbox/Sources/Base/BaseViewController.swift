//
//  BaseViewController.swift
//  Dropbox
//
//  This class is designed to be parent viewController
//  It contains viewModel, disposeBag and navigationBar
//  handling
//  Usage:
//  final class SomeVC: BaseViewController<SomeViewModel>
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

#if canImport(UIKit)
import UIKit
import RxSwift

open class BaseViewController<ViewModel>: CommonViewController {
    // MARK: - Properties
    public let viewModel: ViewModel
    public let disposeBag = DisposeBag()

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Init
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
