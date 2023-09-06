//
//  AppCoordinator.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    // MARK: - Properties
    private var window: UIWindow?
    private var secureStorage = SecureStorage()

    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window

        super.init()
    }

    // MARK: - Setup container

    override func start() {
        window?.makeKeyAndVisible()

        secureStorage.hasCredential ? launchMainFolderVc() : launchInitialVc()
    }
}

// MARK: - AppCoordinator Extensions -

private extension AppCoordinator {

    func launchInitialVc() {
        let signInViewModel = SignInViewModelImpl()

        let coordinator = SingInCoordinator(signInViewModel: signInViewModel)
        coordinator.start()
        self.start(coordinator: coordinator)

        let rootVC = UINavigationController(rootViewController: coordinator.vc)
        coordinator.navigationController = rootVC
        window?.rootViewController = rootVC
    }

    func launchMainFolderVc() {
        let mainFolderViewModel = MainFoldersViewModelImpl()

        let coordinator = MainFoldersCoordinator(mainFoldersViewModel: mainFolderViewModel)
        coordinator.start()
        self.start(coordinator: coordinator)

        let rootVC = UINavigationController(rootViewController: coordinator.vc)
        coordinator.navigationController = rootVC
        window?.rootViewController = rootVC
    }
}
