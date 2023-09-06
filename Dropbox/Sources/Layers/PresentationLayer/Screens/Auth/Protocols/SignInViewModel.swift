//
//  SignInViewModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import RxCocoa
import RxSwift

protocol SignInViewModel {

    func getModel() -> Driver<SignInModel>
}
