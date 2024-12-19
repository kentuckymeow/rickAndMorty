//
//  CharacterCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

protocol CharacterCoordinatorProtocol: Coordinator {
    func start()
}

final class CharacterCoordinator: CharacterCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .character }
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showCharacterViewController()
    }
    
    func showCharacterViewController() {
        let characterViewController = CharacterAssembly.configure(dependencies)
        let navVC = UINavigationController(rootViewController: characterViewController)
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow}).first {
            window.rootViewController = navVC
            UIView.transition(with: window, duration: 1.0, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        } else {
            navVC.modalPresentationStyle = .fullScreen
            navigationController.showDetailViewController(navVC, sender: self)
        }
    }
}
