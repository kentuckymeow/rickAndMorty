//
//  AppCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func start()
}

final class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
        self.dependencies = dependencies
    }
    
    func start() {
        showLaunchFlow()
    }
    
    func showLaunchFlow() {
        print("Starting showLaunchFlow")
        let launchCoordinator = LaunchCoordinator(navigationController, dependencies: dependencies)
        launchCoordinator.finishDelegate = self
        launchCoordinator.start()
        childCoordinators.append(launchCoordinator)
        print("Finished showLaunchFlow")
    }

    func showMainFlow() {
        print("Starting showMainFlow")
        let tabBarCoordinator = TabBarCoordinator(navigationController, dependencies: dependencies)
        tabBarCoordinator.finishDelegate = self
        
        // Проверяем, сколько childCoordinators было до добавления нового
        print("Child coordinators count before adding:", childCoordinators.count)
        
        tabBarCoordinator.start()
        
        // Логируем успешное добавление и состояние массива
        childCoordinators.append(tabBarCoordinator)
        print("Child coordinators count after adding:", childCoordinators.count)
        print("Finished showMainFlow")
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        case.launch:
            showMainFlow()
        case .app, .tabBar, .episodes, .favourites: break
        }
    }
}
