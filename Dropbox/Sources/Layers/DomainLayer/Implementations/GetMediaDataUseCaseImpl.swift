//
//  GetMediaDataUseCaseImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation
import RxCocoa
import RxSwift
import SwiftyDropbox

class GetMediaDataUseCaseImpl {

    // MARK: - Properties
    private let networkService: GetMediaDataFromFolder = GetMediaDataFromFolderNetworkServiceImpl()
}

// MARK: - Protocol conformance
extension GetMediaDataUseCaseImpl: GetMediaDataUseCase {

    func use(path: String) -> Observable<Data> {
        return networkService.getListOfFolders(path: path)
    }
}
