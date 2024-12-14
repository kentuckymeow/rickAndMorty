//
//  LaunchCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

protocol LaunchCoordinatorProtocol: Coordinator{
    func start()
}

final class LaunchCoordinator: LaunchCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .launch }
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showLaunchViewContoller()
    }
    
    func showLaunchViewContoller() {
        let launchViewController = LaunchAssembly.configure(dependencies)
        if let launchViewController = launchViewController as? LaunchViewController {
            launchViewController.didSendEventHandler = { [ weak self] event in
                switch event {
                case.launchComlpete:
                    self?.finish()
                }
            }
        }
        
        navigationController.show(launchViewController, sender: self)
        
    }
}
