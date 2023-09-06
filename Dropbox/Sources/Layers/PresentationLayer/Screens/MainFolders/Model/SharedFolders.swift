//
//  SharedFolders.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

struct SharedFolders {

    var folderName: String?
}

// MARK: - SharedFolders Equatable Protocol -
extension SharedFolders: Equatable {

    static func == (lhs: SharedFolders, rhs: SharedFolders) -> Bool {
        return lhs.folderName == rhs.folderName
    }
}
