//
//  GetNewAccessTokens.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 05.09.2023.
//

import Alamofire
import RxCocoa
import RxSwift
import SwiftyDropbox
import Foundation

protocol GetNewAccessTokens {

    func getNewAccessToken() -> Single<RefreshTokenModel>
}

class GetNewAccessTokensNetworkServiceImpl: GetNewAccessTokens {

    let secureStorage = SecureStorage()

    func getNewAccessToken() -> Single<RefreshTokenModel> {

        return Single<RefreshTokenModel>.create { [weak self] single in

            let refreshToken = self?.secureStorage.getDataFromKeychain()?.refreshToken ?? ""

            let parameters: [String: Any] = [
                "refresh_token": refreshToken,
                "grant_type": "refresh_token",
                "client_id": "uapgkief64q4vym",
                "client_secret": "sidt4zilwbr3iqq"
            ]

            AF.request(AppConstants.apiBaseURL,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.httpBody,
                       headers: ["Content-Type": "application/x-www-form-urlencoded"])
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let data = dataResponse.data else {
                        return
                    }

                    do {
                        let refreshToken = try JSONDecoder().decode(RefreshTokenModel.self, from: data)
                        single(.success(refreshToken))
                    } catch {
                        print("erorr", error.localizedDescription)
                    }
                case let .failure(error):
                    print("Failure", error.localizedDescription)
                    break
                }
            }

            return Disposables.create()
        }
    }
}
