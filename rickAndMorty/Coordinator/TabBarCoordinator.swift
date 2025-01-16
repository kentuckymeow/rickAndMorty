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
        
        let favouritesCoordinator = FavouritesCoordinator(navigationController, dependencies: dependencies)
        favouritesCoordinator.finishDelegate = self
        favouritesCoordinator.start()
        childCoordinators.append(favouritesCoordinator)
        
//        tabBarController.viewControllers = [
//            episodesCoordinator.navigationController,
//            favouritesCoordinator.navigationController
//        ]
//        
//        if let episodesTab = tabBarController.viewControllers?[0] {
//            episodesTab.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(named: "episodesIcon"), tag: 0)
//        }
//        
//        if let favouritesTab = tabBarController.viewControllers?[1] {
//            favouritesTab.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favouritesIcon"), tag: 1)
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
