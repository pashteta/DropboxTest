//
//  MainFolderModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

struct MainFolderModel {

    var searchResults: [SharedFolders] = []
}

// MARK: - Empty
extension MainFolderModel: BaseEmptyModel {

    static func createEmpty() -> MainFolderModel {
        return MainFolderModel(searchResults: [])
    }
}
