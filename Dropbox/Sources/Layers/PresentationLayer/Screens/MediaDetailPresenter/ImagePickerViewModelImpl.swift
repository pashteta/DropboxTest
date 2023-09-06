//
//  ImagePickerViewModelImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxCocoa
import RxSwift
import SwiftyDropbox
import UIKit

final class ImagePickerViewModelImpl: BaseViewModel<ImagePickerModel> {

    // MARK: - Properties
    private var getMediaDataUseCase: GetMediaDataUseCase = GetMediaDataUseCaseImpl()

    private var _mediaPath: String = ""

    private var mainFolderModel = MainFolderMediaContentModel()

    var mediaPath: String {
        _mediaPath
    }

    var name: String {
        mainFolderModel.name ?? ""
    }

    var description: String {
        mainFolderModel.path ?? ""
    }

    // MARK: - Init
    init(model: MainFolderMediaContentModel) {
        self.mainFolderModel = model
        super.init()

        setup()
    }

    private func setup() {
        guard let mediaPath = mainFolderModel.path else { return }
        _mediaPath = mediaPath

        getMediaDataUseCase.use(path: mediaPath)
            .subscribe(onNext: { [weak self] imgData in
                self?.model = ImagePickerModel(imageData: imgData,
                                               mainFolderModel: self?.mainFolderModel)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Protocol conformance

extension ImagePickerViewModelImpl: ImagePickerViewModel { }
