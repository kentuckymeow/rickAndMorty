//
//  EpisodesViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

final class EpisodesViewModel {
    var episodes: [Episodes]
    
    init() {
        self.episodes = [
            Episodes(name: "First Episode", episodes: "S01E01", characters: [
                Character(id: 1, name: "Rick Sanchez"),
            ]),
            Episodes(name: "Second Episode", episodes: "S01E02", characters: [
                Character(id: 1, name: "Rick Sanchez")
            ]),
            Episodes(name: "Third Episode", episodes: "S01E03", characters: [
                Character(id: 1, name: "Morty33")
            ]),
            Episodes(name: "Fourth Episode", episodes: "S01E04", characters: [
                Character(id: 1, name: "Rick44")
            ])
        ]
    }

    func getEpisodes() -> [Episodes] {
        return episodes
    }
}
