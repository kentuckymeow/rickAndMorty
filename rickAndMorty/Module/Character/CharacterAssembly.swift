//
//  CharacterAssembly.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

final class CharacterAssembly {
    static func configure(_ dependencies: IDependencies, character: Character) -> UIViewController {
        return dependencies.moduleContainer.getCharacterView(character)
    }
}
