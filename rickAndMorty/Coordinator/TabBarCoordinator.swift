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
    var finishDelegate: CoordinatorFinishDelegate?
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
