//
//  GetListOfFoldersMediaUseCase.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxSwift

protocol GetListOfFoldersMediaUseCase {

    func use(folder: String) -> Observable<[MainFolderMediaContentModel]>
}

