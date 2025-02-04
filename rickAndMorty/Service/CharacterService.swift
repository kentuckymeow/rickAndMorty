//
//  CharacterService.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

typealias CharacterResults = Result<[Character], Error>
protocol ICharacterService {
    func getCharacters(from urls: [String], completion: @escaping (CharacterResults) -> Void)
}

struct CharacterService: ICharacterService {
    private let networkService: IHTTPClient
    
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    
    func getCharacters(from urls: [String], completion: @escaping (CharacterResults) -> Void) {
        let characterIDs = urls.compactMap { URL(string: $0)?.lastPathComponent }.joined(separator: ",")
        let endpoint = RickAndMortyEndpoint.customURL("\(API.baseURL)/character/\(characterIDs)")

        networkService.request(target: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    if characterIDs.contains(",") {                         let characters = try JSONDecoder().decode([Character].self, from: data)
                        completion(.success(characters))
                    } else { 
                        let character = try JSONDecoder().decode(Character.self, from: data)
                        completion(.success([character]))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
