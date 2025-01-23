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
        let EpisodesVC = EpisodesAssembly.configure(dependencies)
        navigationController.setViewControllers([EpisodesVC], animated: false)
    }
    
}

extension EpisodesCoordinator: EpisodesViewControllerDelegate {
    func didSelectEpisode() {
        let CharacterVC = CharacterAssembly.configure(dependencies)
        navigationController.show(CharacterVC, sender: self)
    }
}
