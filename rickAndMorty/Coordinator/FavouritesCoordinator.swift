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
        let favouritesVC = FavouritesAssembly.configure(dependencies)
        if let viewController = favouritesVC as? FavouritesViewController {
            viewController.delegate = self
        }
        navigationController.setViewControllers([favouritesVC], animated: false)
    }

}

extension FavouritesCoordinator: FavouritesViewControllerDelegate {
    func didSelectEpisode(_ episode: Episode, character: Character) {
        let characterVC = CharacterAssembly.configure(dependencies, character: character)
        navigationController.show(characterVC, sender: self)
    }
}



