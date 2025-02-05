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
    func getCharacterView(_ character: Character) -> UIViewController
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
        let view = FavouritesViewController()
        let viewModel = FavouritesViewModel()
        view.viewModel = viewModel
        return view
    }
}

extension ModuleContainer {
    func getCharacterView(_ character: Character) -> UIViewController {
        let view = CharacterViewController()
        let viewModel = CharacterViewModel(character: character)
        view.viewModel = viewModel
        return view
    }
}

