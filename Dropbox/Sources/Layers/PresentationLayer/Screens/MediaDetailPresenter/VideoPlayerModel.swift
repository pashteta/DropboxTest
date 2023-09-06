//
//  VideoPlayerModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Foundation

struct VideoPlayerModel {

    var videoData: Data?
}

// MARK: - Empty
extension VideoPlayerModel: BaseEmptyModel {

    static func createEmpty() -> VideoPlayerModel {
        return VideoPlayerModel(videoData: nil)
    }
}
