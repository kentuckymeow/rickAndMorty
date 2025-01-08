//
//  EpisodeService.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

typealias EpisodeResults = Result<[Episode], Error>
protocol IEpisodeService {
    func getEpisode(completion: @escaping (EpisodeResults) -> Void)
}

struct EpisodeService: IEpisodeService {
    private let networkService: IHTTPClient
    
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    func getEpisode(completion: @escaping (EpisodeResults) -> Void) {
        networkService.request(target: .episode) { result in
            switch result {
            case .success(let data):
                do {
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    completion(.success(episodes))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                if case let HTTPClientError.invalidResponse(statusCode, data) = error {
                    let trimmedData = data?.prefix(500) // Ограничить до 500 байт
                    let errorMessage = """
                    Error fetching episodes:
                    - Status Code: \(statusCode ?? -1)
                    - Response Data: \(trimmedData.flatMap { String(data: $0, encoding: .utf8) } ?? "No data")
                    """
                    print(errorMessage)
                } else {
                    print("Error: \(error)")
                }
                completion(.failure(error))
            }
        }
    }
}
