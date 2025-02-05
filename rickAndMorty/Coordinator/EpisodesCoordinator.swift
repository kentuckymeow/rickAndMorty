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
        let episodesVC = EpisodesAssembly.configure(dependencies)
        if let viewController = episodesVC as? EpisodesViewController {
            viewController.delegate = self
            
        }
        navigationController.setViewControllers([episodesVC], animated: false)
    }
    
}

extension EpisodesCoordinator: EpisodesViewControllerDelegate {
    func didSelectEpisode(_ episode: Episode, character: Character) {
        let characterVC = CharacterAssembly.configure(dependencies, character: character)
        navigationController.show(characterVC, sender: self)
    }
}


