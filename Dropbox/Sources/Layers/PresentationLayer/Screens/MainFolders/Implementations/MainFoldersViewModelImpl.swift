//
//  MainFoldersViewModelImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 30.08.2023.
//

import RxCocoa
import RxSwift
import SwiftyDropbox
import UIKit

final class MainFoldersViewModelImpl: BaseViewModel<MainFolderModel> {

    // MARK: - Properties
    var openDetailFolder = PublishSubject<(String)>()
    var openAuthPublishSubject = PublishSubject<()>()

    var getListOfSharedFoldersUseCase: GetListOfSharedFoldersUseCase = GetListOfSharedFoldersUseCaseImpl()

    // MARK: - Init
    override init() {
        super.init()

        setup()
    }

    func setup() {
        getListOfSharedFoldersUseCase.use()
            .subscribe(onNext: { [weak self] model in
                self?.model.searchResults = model
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Protocol conformance

extension MainFoldersViewModelImpl: MainFoldersViewModel {

    func onOpenSharedFolderDetails(index: Int) {
        guard let folderName = model.searchResults[index].folderName else { return }
        openDetailFolder.onNext(folderName)
    }

    func moveToAuthFlow() {
        openAuthPublishSubject.onNext(())
    }
}
