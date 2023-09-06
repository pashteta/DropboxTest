//
//  BaseCoordinator.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()

    func start() {
        fatalError("Must be implemented")
    }

    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        parentCoordinator = coordinator
    }

    func finish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
