//
//  MainFolderMediaModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation

struct MainFolderMediaModel {

    var searchResults: [MainFolderMediaContentModel] = []
}

// MARK: - Empty
extension MainFolderMediaModel: BaseEmptyModel {

    static func createEmpty() -> MainFolderMediaModel {
        return MainFolderMediaModel(searchResults: [])
    }
}
