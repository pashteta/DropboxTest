//
//  GetListOfSharedFoldersUseCaseImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyDropbox

class GetListOfSharedFoldersUseCaseImpl {

    // MARK: - Properties
    private let keychainStorage = SecureStorage()
    private let networkService: GetListOfSharedFolders = GetListOfSharedFoldersNetworkServiceImpl()
    private let tokenRenewService: GetNewAccessTokens = GetNewAccessTokensNetworkServiceImpl()
}

// MARK: - Protocol conformance
extension GetListOfSharedFoldersUseCaseImpl: GetListOfSharedFoldersUseCase {

    func use() -> Observable<[SharedFolders]> {

        if keychainStorage.isTokenExpired {
            return tokenRenewService.getNewAccessToken()
                .asObservable()
                .flatMap { [weak self] newAccessToken -> Observable<[SharedFolders]> in
                    guard let self = self else { return Observable.just([]) }
                    self.keychainStorage.updateToken(with: newAccessToken)

                    return self.getListOfFolders()
                }
        } else {
            return getListOfFolders()
        }
    }

    func getListOfFolders() -> Observable<[SharedFolders]> {
        return networkService.getListOfFolders()
            .flatMap { self.getSharedFolder(for: $0) }
    }
}

private extension GetListOfSharedFoldersUseCaseImpl {

    func getSharedFolder(for entity: Sharing.ListFoldersResult) -> Observable<[SharedFolders]> {
        let entityFolderObservable = Observable.from([
            entity.entries.map { SharedFolders(folderName: $0.name) }
        ])

        return entityFolderObservable
    }
}

