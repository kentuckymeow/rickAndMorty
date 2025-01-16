//
//  EpisodesCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 13.01.2025.
//

import UIKit

protocol EpisodesCoordinatorProtocol: Coordinator {
    func start()
}

final class EpisodesCoordinator: EpisodesCoordinatorProtocol {
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
        showEpisodesFlow()
    }
    
    func showEpisodesFlow() {
        let EpisodesViewController = EpisodesAssembly.configure(dependencies)
        navigationController.setViewControllers([EpisodesViewController], animated: false)
    }
    
    func showDetails() {
        let CharacterViewController = CharacterAssembly.configure(dependencies)
        navigationController.pushViewController(CharacterViewController, animated: true)
    }
}
