//
//  SingInCoordinator.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import Foundation
import RxSwift

class SingInCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()

    private let signInViewModel: SignInViewModelImpl

    let vc: SignInViewController!
    
    // MARK: - Init
    init(signInViewModel: SignInViewModelImpl) {
        self.signInViewModel = signInViewModel
        self.vc = SignInViewController(viewModel: signInViewModel)
        super.init()
    }

    override func start() {
        navigationController.pushViewController(vc, animated: true)
    }
}
