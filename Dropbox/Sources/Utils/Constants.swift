//
//  Constants.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

enum AppConstants {

    static let apiBaseURL = "https://api.dropbox.com/oauth2/token"

    static let dropBoxApiAuthMetadataScope = "files.metadata.read"
    static let dropBoxApiAuthContentScope = "files.content.read"
    static let dropBoxApiAuthSharingScope = "sharing.read"

    static let thumnbailsCachePath = "thumbnails"
    static let videoFormat = ["avi", "mp4", "mov"]
}
