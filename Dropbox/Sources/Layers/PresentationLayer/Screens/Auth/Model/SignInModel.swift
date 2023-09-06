//
//  SignInModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 06.09.2023.
//

struct SignInModel { }

// MARK: - Empty
extension SignInModel: BaseEmptyModel {

    static func createEmpty() -> SignInModel {
        return SignInModel()
    }
}
