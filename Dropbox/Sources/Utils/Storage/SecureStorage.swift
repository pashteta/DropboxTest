//
//  SecureStorage.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 05.09.2023.
//

import Foundation
import KeychainAccess
import UIKit

protocol KeychainProtocol {
    func clearAll()
}

struct Tokens: Codable {
    let accessToken: String
    let refreshToken: String
    let expiredAt: TimeInterval
}

final class SecureStorage: KeychainProtocol {

    private enum Const {
        static let encodedCredentialKey = "encodedCredential"
        static let keychainLabelKey = "com.app.dropbox"
    }

    private let keychain = Keychain(service: Const.keychainLabelKey)

    var hasCredential: Bool {
        getDataFromKeychain() != nil
    }

    var isTokenExpired: Bool {
        hasTimestampPassed()
    }

    func saveDataToKeychain(model: Tokens) {
        let propertyListEncoder = PropertyListEncoder()
        guard let savingData = try? propertyListEncoder.encode(model) else { return }
        keychain[data: Const.encodedCredentialKey] = NSData(data: savingData) as Data
    }

    func removeDataFromKeychain() {
        keychain[data: Const.encodedCredentialKey] = nil
    }

    func getDataFromKeychain() -> Tokens? {
        guard let retrievedData = keychain[data: Const.encodedCredentialKey] else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        let data = try? propertyListDecoder.decode(Tokens.self, from: retrievedData)
        return data
    }

    func hasTimestampPassed() -> Bool {
        guard let tokenModel = getDataFromKeychain() else { return true }

        let timestamp = tokenModel.expiredAt
        let currentTime = Date().timeIntervalSince1970

        return timestamp <= currentTime
    }

    func updateToken(with model: RefreshTokenModel) {
        guard let tokenModel = getDataFromKeychain(),
              let newToken = model.accessToken  else { return }
        clearAll()

        let calendar = Calendar.current

        let currentDate = Date()

        var dateComponents = DateComponents()
        dateComponents.hour = 4
        dateComponents.minute = -1

        if let newDate = calendar.date(byAdding: dateComponents, to: currentDate) {
            let timeInterval = newDate.timeIntervalSince1970

            saveDataToKeychain(model: Tokens(accessToken: newToken,
                                             refreshToken: tokenModel.refreshToken,
                                             expiredAt: timeInterval))
        }
    }

    func clearAll() {
        try? keychain.removeAll()
    }
}
