//
//  CharacterViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 25.01.2025.
//

import Foundation

protocol CharacterViewModelDelegate: AnyObject {
    var updateHandler: (([Character]) -> Void)? { get set }
    func getCharacterInfo()
}

final class CharacterViewModel: CharacterViewModelDelegate {
    var updateHandler: (([Character]) -> Void)?
    private var characterService: ICharacterService?
    private var characters: [Character] = []
    
    init(_ dependencies: IDependencies) {
        characterService = dependencies.characterService
    }
    
    init(characters: [Character]) {
        self.characters = characters
    }
    
    func getCharacterInfo() {
        print("get characterinfo")
    }
}

