//
//  MainFolderDetailCoordinator.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import AVFoundation
import AVKit
import Foundation
import RxSwift

class MainFolderDetailCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()

    private let mainFolderDetailViewModel: MainFolderDetailViewModelImpl

    let vc: MainFolderDetailViewController!
    
    // MARK: - Init
    init(mainFolderDetailViewModel: MainFolderDetailViewModelImpl) {
        self.mainFolderDetailViewModel = mainFolderDetailViewModel
        self.vc = MainFolderDetailViewController(viewModel: mainFolderDetailViewModel)
        super.init()

        setupBinding()
    }

    override func start() {
        navigationController.pushViewController(vc, animated: true)
    }

    // MARK: - Methods

    func setupBinding() {
        mainFolderDetailViewModel
            .openMediaImageSubject
            .subscribe(onNext: { model in
                self.openImagePresenter(model: model)
            })
            .disposed(by: disposeBag)

        mainFolderDetailViewModel
            .openVideoPlaySubject
            .subscribe(onNext: { url in
                self.presentVideoPlayer(with: url)
            })
            .disposed(by: disposeBag)
    }

    private func openImagePresenter(model: MainFolderMediaContentModel) {
        let vc = ImagePickerViewController(viewModel: ImagePickerViewModelImpl(model: model))
        self.navigationController.pushViewController(vc, animated: true)
    }

    private func presentVideoPlayer(with url: URL) {
        let player = AVPlayer(url: url)

        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        navigationController.present(playerViewController, animated: true) {
            player.play()
        }
    }
}
