//
//  Dependencies.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import Foundation

protocol IDependencies {
    var moduleContainer: IModuleContainer { get }
}

final class Dependencies: IDependencies {
    lazy var moduleContainer: IModuleContainer = ModuleContainer(self)
}
