//
//  MainFoldersViewModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 30.08.2023.
//

import RxCocoa
import RxSwift

protocol MainFoldersViewModel {

    var openDetailFolder: PublishSubject<(String)> { get set }
    var openAuthPublishSubject: PublishSubject<()> { get set }

    func getModel() -> Driver<MainFolderModel>

    func onOpenSharedFolderDetails(index: Int)
    func moveToAuthFlow()
}

