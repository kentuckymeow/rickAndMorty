//
//  CharacterViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 25.01.2025.
//

import Foundation

protocol CharacterViewModelDelegate: AnyObject {
    var updateHandler: ((Character) -> Void)? { get set }
    func getCharacterInfo()
}

final class CharacterViewModel: CharacterViewModelDelegate {
    var updateHandler: ((Character) -> Void)?
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func getCharacterInfo() {
        updateHandler?(character)
    }
}

