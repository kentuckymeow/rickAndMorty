//
//  ModuleContainer.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

protocol IModuleContainer {
    func getLaunchView() -> UIViewController
    func getEpisodesView() -> UIViewController
    func getFavouritesView() -> UIViewController
    func getCharacterView() -> UIViewController
}

final class ModuleContainer: IModuleContainer {
    private let dependencies: IDependencies
    required init(_ dependencies: IDependencies) {
        self.dependencies = dependencies
    }
}

extension ModuleContainer {
    func getLaunchView() -> UIViewController {
        return LaunchViewController()
    }
}

extension ModuleContainer {
    func getEpisodesView() -> UIViewController {
        let view = EpisodesViewController()
        let viewModel = EpisodesViewModel(dependencies)
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

