//
//  FavouritesCoordinator.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 13.01.2025.
//

import UIKit

protocol FavouritesCoordinatorProtocol: Coordinator {
    func start()
}

final class FavouritesCoordinator: FavouritesCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    var type: CoordinatorType { .favourites}
    var dependencies: IDependencies
    
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        showFavouritesFlow()
    }
    
    func showFavouritesFlow() {
        let favouritesViewController = FavouritesAssembly.configure(dependencies)
        let characterViewController = CharacterAssembly.configure(dependencies)
        let navVC = UINavigationController(rootViewController: favouritesViewController)
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.rootViewController = navVC
            UIView.transition(with: window, duration: 1.0, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        } else {
            navVC.modalPresentationStyle = .fullScreen
            navigationController.showDetailViewController(navVC, sender: self)
        }
    }
}
