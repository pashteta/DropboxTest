//
//  GetListOfFoldersMediaUseCaseImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyDropbox

class GetListOfFoldersMediaUseCaseImpl {

    // MARK: - Properties
    private let networkService: GetSharedFolderMedia = GetSharedFolderMediaNetworkServiceImpl()
    private let tokenRenewService: GetNewAccessTokens = GetNewAccessTokensNetworkServiceImpl()
    private let keychainStorage = SecureStorage()
}

// MARK: - Protocol conformance
extension GetListOfFoldersMediaUseCaseImpl: GetListOfFoldersMediaUseCase {

    func use(folder: String) -> Observable<[MainFolderMediaContentModel]> {

        if keychainStorage.isTokenExpired {
            return tokenRenewService.getNewAccessToken()
                .asObservable()
                .flatMap { [weak self] newAccessToken -> Observable<[MainFolderMediaContentModel]> in
                    guard let self = self else { return Observable.just([]) }
                    self.keychainStorage.updateToken(with: newAccessToken)
                    return self.getListOfMedia(folder: folder)
                }
        } else {
            return getListOfMedia(folder: folder)
        }
    }

    func getListOfMedia(folder: String) -> Observable<[MainFolderMediaContentModel]> {
        return networkService.getListOfMedia(for: folder)
            .flatMap { self.getMedia(for: $0) }
    }
}

private extension GetListOfFoldersMediaUseCaseImpl {

    func getMedia(for entity: Files.ListFolderResult) -> Observable<[MainFolderMediaContentModel]> {
        let entityFolderObservable = Observable.from([
            entity.entries.map { MainFolderMediaContentModel(name: $0.name,
                                                             path: $0.pathDisplay,
                                                             description: $0.previewUrl)}
        ])

        return entityFolderObservable
    }
}
