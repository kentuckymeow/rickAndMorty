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
    
    // Инициализация с сервисом для загрузки данных
    init(_ dependencies: IDependencies) {
        characterService = dependencies.characterService
    }
    
    // Инициализация с уже известным набором персонажей
    init(characters: [Character]) {
        self.characters = characters
    }
    
    func getCharacterInfo() {
        // Если данные уже есть, передаем их через updateHandler
        if !characters.isEmpty {
            updateHandler?(characters)
        } else {
            // Иначе загружаем данные с помощью сервиса
            characterService?.getCharacters { [weak self] characterResult in
                switch characterResult {
                case .success(let character):
                    self?.characters = character
                    self?.updateHandler?(character)
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
            }
        }
    }
}

