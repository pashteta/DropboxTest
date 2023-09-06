//
//  MainFolderMediaContentModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation

struct MainFolderMediaContentModel {

    var name: String?
    var path: String?
    var description: String?
}

// MARK: - MainFolderMediaContentModel Equatable Protocols -
extension MainFolderMediaContentModel: Equatable {

    static func == (lhs: MainFolderMediaContentModel,
                    rhs: MainFolderMediaContentModel) -> Bool {

        return lhs.name == rhs.name &&
        lhs.path == rhs.path &&
        lhs.description == rhs.description
    }
}
