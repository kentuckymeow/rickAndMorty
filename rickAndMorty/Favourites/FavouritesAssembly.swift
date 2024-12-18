//
//  FavouritesAssembly.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.12.2024.
//

import UIKit

final class FavouritesAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getFavouritesView()
    }
}
