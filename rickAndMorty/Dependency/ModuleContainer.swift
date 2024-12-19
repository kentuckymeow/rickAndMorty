//
//  ModuleContainer.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

protocol IModuleContainer {
    func getLaunchView() -> UIViewController
    func getTabBarView() -> UIViewController
    func getEpisodesView() -> UIViewController
    func getFavouritesView() -> UIViewController
    func getCharacterView() -> UIViewController
}

final class ModuleContainer: IModuleContainer {
    private let dependencies: IDependencies
    private let navigationController: UINavigationController
    required init(_ navigationController: UINavigationController, dependencies: IDependencies) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
}

extension ModuleContainer {
    func getLaunchView() -> UIViewController {
        return LaunchViewController()
    }
}

extension ModuleContainer {
    func getTabBarView() -> UIViewController {
        let view = TabBarViewController()
        let episodesVC = EpisodesAssembly.configure(dependencies)
        let favouritesVC = FavouritesAssembly.configure(dependencies)
        view.controllers = [episodesVC,favouritesVC]
        view.startIndex = 0
        return view
    }
}

extension ModuleContainer {
    func getEpisodesView() -> UIViewController {
        let view = EpisodesViewController()
        
        let appCoordinator = AppCoordinator(navigationController, dependencies: dependencies) // Пример, если у вас нет синглтона для AppCoordinator
        let router = EpisodesRouter(appCoordator: appCoordinator)
        
        let viewModel = EpisodesViewModel(router: router)
        view.viewModel = viewModel
        return view
    }
}

extension ModuleContainer {
    func getFavouritesView() -> UIViewController {
        return FavouritesViewController()
    }
}

extension ModuleContainer {
    func getCharacterView() -> UIViewController {
        return CharacterViewController()
    }
}

