//
//  SignInViewModelImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import RxCocoa
import RxSwift

final class SignInViewModelImpl: BaseViewModel<SignInModel> {

    // MARK: - Init
    override init() {
        super.init()

        model = .createEmpty()
    }
}

// MARK: - Protocol conformance

extension SignInViewModelImpl: SignInViewModel { }
