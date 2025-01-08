//
//  EpisodesViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//
import Foundation

protocol EpisodeViewModelDelegate: AnyObject {
    var updateHandler: (([Episode]) -> Void)? { get set }
    func getEpisode()
}

final class EpisodesViewModel: EpisodeViewModelDelegate {
    var updateHandler: (([Episode]) -> Void)?
    private var episodeService: IEpisodeService
    private var episode: [Episode]?
    
    init(_ dependencies: IDependencies) {
        episodeService = dependencies.episodeService
    }
    
    func getEpisode() {
        episodeService.getEpisode { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.episode = episodes
                self?.updateHandler?(episodes)
                
                if let randomEpisode = episodes.randomElement() {
                    print("Random episode number: \(randomEpisode.episode)")
                }
                
            case .failure(let error):
                print("Error fetching episodes: \(error)")
            }
        }
    }
}


