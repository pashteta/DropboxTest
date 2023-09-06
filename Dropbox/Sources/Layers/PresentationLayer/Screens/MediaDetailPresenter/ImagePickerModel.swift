//
//  ImagePickerModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation

struct ImagePickerModel {

    var imageData: Data?
    var mainFolderModel: MainFolderMediaContentModel?
}

// MARK: - Empty
extension ImagePickerModel: BaseEmptyModel {

    static func createEmpty() -> ImagePickerModel {
        return ImagePickerModel(imageData: nil, mainFolderModel: nil)
    }
}
