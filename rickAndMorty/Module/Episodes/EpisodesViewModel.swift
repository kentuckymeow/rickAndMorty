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
    
    private var filteredEpisodes: [Episode] = []
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
                self?.filteredEpisodes = episodes
                
                let characterURLs = episodes.flatMap { $0.characters }
                self?.characterService.getCharacters(from: characterURLs) { [weak self] characterResult in
                    switch characterResult {
                    case .success(let characters):
                        self?.allCharacters = characters
                        self?.filterCharactersForEpisodes()
                    case .failure(let error):
                        print("Error fetching characters: \(error)")
                    }
                }
            case .failure(let error):
                print("Error fetching episodes: \(error)")
            }
        }
    }

    
    private func filterCharactersForEpisodes() {
        let episodeURLs = filteredEpisodes.flatMap { $0.characters }
        filteredCharacters = allCharacters.filter { episodeURLs.contains($0.url) }
        updateHandler?(filteredEpisodes, filteredCharacters)
    }

    func searchEpisodes(query: String) {
        guard !query.isEmpty else {
            filteredEpisodes = allEpisodes
            filterCharactersForEpisodes()
            return
        }

        filteredEpisodes = allEpisodes.filter { episode in
            episode.name.lowercased().contains(query.lowercased()) ||
            episode.episode.lowercased().contains(query.lowercased())
        }
        
        filterCharactersForEpisodes()
    }
    
    func statusSelected(status: String) {
        guard let statusEnum = CharacterStatus(rawValue: status) else { return }
        filteredCharacters = allCharacters.filter { $0.status == statusEnum.rawValue }
        filterEpisodesForCharacters()
    }

    func genderSelected(gender: String) {
        guard let genderEnum = CharacterGender(rawValue: gender) else { return }
        filteredCharacters = allCharacters.filter { $0.gender == genderEnum.rawValue }
        filterEpisodesForCharacters()
    }

    private func filterEpisodesForCharacters() {
        let characterURLs = filteredCharacters.map { $0.url }
        filteredEpisodes = allEpisodes.filter { episode in
            episode.characters.contains { characterURLs.contains($0) }
        }
        updateHandler?(filteredEpisodes, filteredCharacters)
    }
}
