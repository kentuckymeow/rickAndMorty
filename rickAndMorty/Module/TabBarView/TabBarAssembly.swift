//
//  TabBarAssembly.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 17.12.2024.
//

import UIKit

final class TabBarAssembly {
    static func configure(_ dependencies: IDependencies) -> UIViewController {
        return dependencies.moduleContainer.getTabBarView()
    }
}
