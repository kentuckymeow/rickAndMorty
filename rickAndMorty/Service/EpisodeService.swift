//
//  EpisodeService.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

typealias EpisodeResults = Result<[Episode], Error>
protocol IEpisodeService {
    func getEpisodes(completion: @escaping (EpisodeResults) -> Void)
}

struct EpisodeService: IEpisodeService {
    private let networkService: IHTTPClient
    
    init(_ dependencies: IDependencies) {
        networkService = dependencies.networkService
    }
    
    func getEpisodes(completion: @escaping (EpisodeResults) -> Void) {
        networkService.request(target: .episode) { result in
            switch result {
            case .success(let data):
                do {
                    let episodesResponse = try JSONDecoder().decode(EpisodesResponse.self, from: data)
                    completion(.success(episodesResponse.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
