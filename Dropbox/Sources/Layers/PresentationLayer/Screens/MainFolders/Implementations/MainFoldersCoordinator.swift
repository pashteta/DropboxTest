//
//  MainFoldersCoordinator.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 30.08.2023.
//

import Foundation
import RxSwift
import SDWebImage

class MainFoldersCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()

    private let mainFoldersViewModel: MainFoldersViewModelImpl
    private let secureStorage = SecureStorage()

    let vc: MainFoldersViewController!

    // MARK: - Init
    init(mainFoldersViewModel: MainFoldersViewModelImpl) {
        self.mainFoldersViewModel = mainFoldersViewModel
        self.vc = MainFoldersViewController(viewModel: mainFoldersViewModel)
        super.init()

        setupBinding()
    }

    override func start() {
        navigationController.pushViewController(vc, animated: true)
    }

    // MARK: - Methods

    func setupBinding() {
        mainFoldersViewModel
            .openDetailFolder
            .subscribe(onNext: { folderName in
                self.openDetailFolderScreen(with: folderName)
            })
            .disposed(by: disposeBag)

        mainFoldersViewModel
            .openAuthPublishSubject
            .subscribe(onNext: { _ in
                SDImageCache.shared.clearMemory()
                SDImageCache.shared.clearDisk()

                CacheManager.shared.clear()
                self.secureStorage.clearAll()
                self.setAuthVc()
            })
            .disposed(by: disposeBag)
    }

    private func openDetailFolderScreen(with folder: String) {
        let coordinator = MainFolderDetailCoordinator(mainFolderDetailViewModel:
                                                        MainFolderDetailViewModelImpl(sharedFolderName: folder))
        coordinator.navigationController = navigationController
        coordinator.start(coordinator: coordinator)
        coordinator.start()
    }

    private func setAuthVc() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.appCoordinator?.start()
    }
}
