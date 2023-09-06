//
//  RefreshTokenModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 06.09.2023.
//

struct RefreshTokenModel: Codable {

    var accessToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
