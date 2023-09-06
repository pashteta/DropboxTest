//
//  MainFolderDetailViewModelImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxCocoa
import RxSwift
import SwiftyDropbox
import UIKit

final class MainFolderDetailViewModelImpl: BaseViewModel<MainFolderMediaModel> {

    // MARK: - Properties
    var isLoading = BehaviorRelay<Bool>(value: false)

    var openMediaImageSubject = PublishSubject<MainFolderMediaContentModel>()
    var openVideoPlaySubject = PublishSubject<URL>()

    var getListOfSharedFoldersMediaUseCase: GetListOfFoldersMediaUseCase = GetListOfFoldersMediaUseCaseImpl()
    private var getMediaDataUseCase: GetMediaDataUseCase = GetMediaDataUseCaseImpl()

    private var page: Int = 0

    private var _mediaPath: String = ""

    var mediaPath: String {
        _mediaPath
    }

    // MARK: - Init
    init(sharedFolderName: String) {
        super.init()

        setup(folderName: sharedFolderName)
    }

    func setup(folderName: String) {
        isLoading.accept(true)
        
        getListOfSharedFoldersMediaUseCase.use(folder: folderName)
            .subscribe(onNext: { [weak self] model in
                self?.isLoading.accept(false)
                self?.model.searchResults = model
            })
            .disposed(by: disposeBag)
    }

    func donwloadVideData(mediaPath: String) {
        isLoading.accept(true)

        if let cachedURL = CacheManager.shared.getCachedVideoURL(forKey: mediaPath) {
            self.isLoading.accept(false)
            self.openVideoPlaySubject.onNext(cachedURL)
        } else {
            getMediaDataUseCase.use(path: mediaPath)
                .subscribe(onNext: { [weak self] videoData in
                    self?.isLoading.accept(false)
                    
                    let correctedCachedPath = mediaPath.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                    CacheManager.shared.saveVideoData(videoData, forKey: correctedCachedPath) { result in
                        switch result {
                        case .success(let fileURL):
                            self?.openVideoPlaySubject.onNext(fileURL)
                        case .failure(let error):
                            print("error", error)
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}

// MARK: - Protocol conformance

extension MainFolderDetailViewModelImpl: MainFolderDetailViewModel {

    func onOpenMediaDetailScreen(index: Int) {
        guard let mediaFilePath = model.searchResults[index].path else { return }

        var isVideoFormat = false

        AppConstants.videoFormat.forEach { val in
            if mediaFilePath.contains(val) {
                isVideoFormat = true
            }
        }

        if isVideoFormat {
            donwloadVideData(mediaPath: mediaFilePath)
        } else {
            openMediaImageSubject.onNext(model.searchResults[index])
        }
    }
}
