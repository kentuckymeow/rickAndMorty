//
//  EpisodesAssembly.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.12.2024.
//

import UIKit

final class EpisodesAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getEpisodesView()
    }
}
