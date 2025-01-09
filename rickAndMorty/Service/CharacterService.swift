//
//  CharacterService.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

typealias CharacterResults = Result<[Character], Error>
protocol ICharacterService {
    func getCharacters(completion: @escaping (CharacterResults) -> Void)
}

struct CharacterService: ICharacterService {
    private let networkService: IHTTPClient
    
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    
    func getCharacters(completion: @escaping (CharacterResults) -> Void) {
        networkService.request(target: .character) { result in
            switch result {
            case .success(let data):
                do {
                    let charactersResponse = try
                        JSONDecoder().decode(CharacterResponce.self, from: data)
                    completion(.success(charactersResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
