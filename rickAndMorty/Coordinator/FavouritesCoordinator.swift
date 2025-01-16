//
//  FavouritesCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 13.01.2025.
//

import UIKit

protocol FavouritesCoordinatorProtocol: Coordinator {
    func start()
}

final class FavouritesCoordinator: FavouritesCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .episodes }
    var dependencies: IDependencies

    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        showFavouritesFlow()
    }

    func showFavouritesFlow() {
        let favouritesViewController = FavouritesAssembly.configure(dependencies)
        navigationController.setViewControllers([favouritesViewController], animated: false)
    }

    private func showDetails() {
        let characterViewController = CharacterAssembly.configure(dependencies)
        navigationController.pushViewController(characterViewController, animated: true)
    }
}



