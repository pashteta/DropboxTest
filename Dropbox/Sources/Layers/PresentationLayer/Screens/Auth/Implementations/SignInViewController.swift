//
//  SignInViewController.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftyDropbox

final class SignInViewController: BaseViewController<SignInViewModelImpl> {

    private let screenView = SignInView()

    // MARK: - Init
    override init(viewModel: SignInViewModelImpl) {
        super.init(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindData()
        bindInteractions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Setup
    private func setupViews() {
        view = screenView
    }
}

// MARK: - Data binding
private extension SignInViewController {

    func bindData() { }

    func bindInteractions() {
        screenView.btnLoginIn.rx.tap.subscribe(
            onNext: { [weak self] _ in
                self?.autorizeFromController()
            }
        ).disposed(by: disposeBag)
    }

    func autorizeFromController() {
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: [AppConstants.dropBoxApiAuthMetadataScope,
                                                                   AppConstants.dropBoxApiAuthContentScope,
                                                                   AppConstants.dropBoxApiAuthSharingScope,],
                                        includeGrantedScopes: false)

        DropboxClientsManager.authorizeFromControllerV2(
            UIApplication.shared,
            controller: self,
            loadingStatusDelegate: nil,
            openURL: {(url: URL) -> Void in UIApplication.shared.open(url)},
            scopeRequest: scopeRequest
        )
    }
}

