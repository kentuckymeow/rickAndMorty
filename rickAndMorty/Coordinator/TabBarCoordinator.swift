//
//  TabBarCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 17.12.2024.
//

import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    func start()
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tabBar }
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showTabBarViewController()
    }
    
    func showEpisodesModuleFlow() {
        let episodesCoordinator = EpisodesCoordinator(navigationController,dependencies: dependencies)
        episodesCoordinator.finishDelegate = self
        episodesCoordinator.start()
        childCoordinators.append(episodesCoordinator)
    
    }
    
    func showFavoritesModuleFlow() {
        let favouritesCoordinator =
        FavouritesCoordinator(navigationController,dependencies: dependencies)
        favouritesCoordinator.finishDelegate = self
        favouritesCoordinator.start()
        childCoordinators.append(favouritesCoordinator)
        
    }
    
    func showTabBarViewController() {
        let tabBarViewController = TabBarAssembly.configure(dependencies)
        let navVC = UINavigationController(rootViewController: tabBarViewController)
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.rootViewController = navVC
            UIView.transition(with: window, duration: 1.0, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        } else {
            navVC.modalPresentationStyle = .fullScreen
            navigationController.showDetailViewController(navVC, sender: self)
        }
    }
}

extension TabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type})
        switch childCoordinator.type {
        case.episodes:
            showEpisodesModuleFlow()
        case.favourites:
            showFavoritesModuleFlow()
        case .app,.launch, .tabBar: break
        }
    }
    
}
