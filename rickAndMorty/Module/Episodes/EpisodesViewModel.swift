//
//  EpisodesViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//
import Foundation

protocol EpisodeViewModelDelegate: AnyObject {
    var updateHandler: (([Episode], [Character]) -> Void)? { get set }
    func getEpisodeAndCharacter()
}

final class EpisodesViewModel: EpisodeViewModelDelegate {
    var updateHandler: (([Episode],[Character]) -> Void)?
    private var episodeService: IEpisodeService
    private var characterService: ICharacterService
    
    init(_ dependencies: IDependencies) {
        episodeService = dependencies.episodeService
        characterService = dependencies.characterService
    }
    
    func getEpisodeAndCharacter() {
        episodeService.getEpisodes { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.characterService.getCharacters { [weak self] characterResult in
                    switch characterResult {
                    case .success(let characters):
                        self?.updateHandler?(episodes, characters)
                    case .failure(let error):
                        print("Error fetching characters: \(error)")
                    }
                }
            case .failure(let error):
                print("Error fetching episodes: \(error)")
            }
        }
    }
}


