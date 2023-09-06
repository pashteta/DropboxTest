//
//  AppDelegate.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import AppTrackingTransparency
import UIKit
import CoreData
import SwiftyDropbox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var secureStorage = SecureStorage()
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DropboxClientsManager.setupWithAppKey("uapgkief64q4vym")

        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()

        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        DropboxClientsManager.handleRedirectURL(url, completion: { [weak self] authResult in
            switch authResult {
            case .success(let token):
                print("Dropbox authorization was successful!")
                let tokenModel = Tokens(accessToken: token.accessToken,
                                        refreshToken: token.refreshToken ?? "",
                                        expiredAt: token.tokenExpirationTimestamp ?? 0.0)

                self?.secureStorage.saveDataToKeychain(model: tokenModel)
                self?.appCoordinator?.start()
            case .cancel:
                print("Dropbox authorization was cancelled.")
            case .error(_, let description):
                print("Error: \(description)")
            case .none:
                print("none")
            }
        })
        return false
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("enable tracking")
            case .denied:
                print("disable tracking")
            default:
                print("disable tracking")
            }
        }
    }
}

