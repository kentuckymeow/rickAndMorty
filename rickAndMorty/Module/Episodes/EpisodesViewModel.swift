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
    func searchEpisodes(query: String)
    func statusSelected(status: String)
    func genderSelected(gender: String)
}

final class EpisodesViewModel: EpisodeViewModelDelegate {
    
    var updateHandler: (([Episode], [Character]) -> Void)?
    private var episodeService: IEpisodeService
    private var characterService: ICharacterService
    private var allEpisodes: [Episode] = []
    private var allCharacters: [Character] = []
    private var filteredCharacters: [Character] = []

    init(_ dependencies: IDependencies) {
        episodeService = dependencies.episodeService
        characterService = dependencies.characterService
    }
    
    func getEpisodeAndCharacter() {
        episodeService.getEpisodes { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.allEpisodes = episodes
                self?.characterService.getCharacters { [weak self] characterResult in
                    switch characterResult {
                    case .success(let characters):
                        self?.allCharacters = characters
                        self?.filteredCharacters = characters
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
    
    func searchEpisodes(query: String) {
        guard !query.isEmpty else {
            updateHandler?(allEpisodes, filteredCharacters)
            return
        }

        let filteredEpisodes = allEpisodes.filter { episode in
            episode.name.lowercased().contains(query.lowercased()) ||
            episode.episode.lowercased().contains(query.lowercased())
        }

        updateHandler?(filteredEpisodes, filteredCharacters)
    }
    
    func statusSelected(status: String) {
        guard let statusEnum = CharacterStatus(rawValue: status) else { return }
        filteredCharacters = allCharacters.filter { $0.status == statusEnum.rawValue }
        let filteredEpisodes = allEpisodes.filter { episode in
            filteredCharacters.contains { $0.episode.contains(episode.url) }
        }
        updateHandler?(filteredEpisodes, filteredCharacters)
    }

    func genderSelected(gender: String) {
        guard let genderEnum = CharacterGender(rawValue: gender) else { return }
        filteredCharacters = allCharacters.filter { $0.gender == genderEnum.rawValue }
        let filteredEpisodes = allEpisodes.filter { episode in
            filteredCharacters.contains { $0.episode.contains(episode.url) }
        }
        updateHandler?(filteredEpisodes, filteredCharacters)
    }

}
