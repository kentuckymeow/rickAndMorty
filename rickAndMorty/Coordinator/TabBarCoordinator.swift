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

final class TabBarCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .tabBar }
    var dependencies: IDependencies
    var tabBarController: UITabBarController

    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.tabBarController = UITabBarController()
    }

    func start() {
        print("Starting TabBarCoordinator")
        setupTabBarController()
        navigationController.pushViewController(tabBarController, animated: true)
        print("Finished setting up TabBarController and pushed to navigation stack")
    }

    private func setupTabBarController() {
        print("Setting up TabBarController")
         
        tabBarController.tabBar.backgroundColor = UIColor.white
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.1
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBarController.tabBar.layer.shadowRadius = 4
        tabBarController.tabBar.layer.masksToBounds = false
        tabBarController.tabBar.itemPositioning = .centered
        
        let episodesNavController = UINavigationController()
        let episodesCoordinator = EpisodesCoordinator(episodesNavController, dependencies: dependencies)
        episodesCoordinator.finishDelegate = self
        episodesCoordinator.start()
        childCoordinators.append(episodesCoordinator)

        let favouritesNavController = UINavigationController()
        let favouritesCoordinator = FavouritesCoordinator(favouritesNavController, dependencies: dependencies)
        favouritesCoordinator.finishDelegate = self
        favouritesCoordinator.start()
        childCoordinators.append(favouritesCoordinator)

        tabBarController.viewControllers = [
            episodesCoordinator.navigationController,
            favouritesCoordinator.navigationController
        ]
        
        print("ViewControllers count: \(tabBarController.viewControllers?.count ?? 0)")

        if let episodesTab = tabBarController.viewControllers?[0] {
            episodesTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "episodesIcon"), tag: 0)
            print("Configured Episodes tab")
        } else {
            print("Episodes tab could not be configured")
        }

        if let favouritesTab = tabBarController.viewControllers?[1] {
            favouritesTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "favouritesIcon"), tag: 1)
            print("Configured Favourites tab")
        } else {
            print("Favourites tab could not be configured")
        }

        print("Finished setting up TabBarController")
    }
}

extension TabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        print("Finishing child coordinator: \(childCoordinator.type)")
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
        if childCoordinator.type == .episodes || childCoordinator.type == .favourites {
            finish()
            print("Finished TabBarCoordinator")
        }
    }
}
