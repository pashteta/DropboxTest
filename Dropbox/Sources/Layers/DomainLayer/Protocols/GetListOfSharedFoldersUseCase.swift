//
//  GetListOfSharedFoldersUseCase.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxSwift

protocol GetListOfSharedFoldersUseCase {

    func use() -> Observable<[SharedFolders]>
}

