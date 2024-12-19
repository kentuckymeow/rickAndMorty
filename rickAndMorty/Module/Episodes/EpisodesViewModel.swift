//
//  EpisodesViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

final class EpisodesViewModel {
    var episodes: [Episodes]
    var router: EpisodesRouter
    
    init(router: EpisodesRouter) {
        self.router = router
        self.episodes = [
            Episodes(name: "First Episode", episodes: "S01E01", characters: [
                Character(id: 1, name: "Rick"),
            ]),
            Episodes(name: "Second Episode", episodes: "S01E02", characters: [
                Character(id: 1, name: "Rick")
            ]),
            Episodes(name: "Third Episode", episodes: "S01E03", characters: [
                Character(id: 1, name: "Morty33")
            ]),
            Episodes(name: "Fourth Episode", episodes: "S01E04", characters: [
                Character(id: 1, name: "Rick44")
            ])
        ]
    }
    
    func showCharacterDetails(index: Int) {
        var currentIndex = 0
        for episode in episodes {
            if index < currentIndex + episode.characters.count {
                let character = episode.characters[index - currentIndex]
                router.showCharacterDetails(for: character.id)
                return
            }
            currentIndex += episode.characters.count
        }
        print("Index out of range")
    }
    
    func getEpisodes() -> [Episodes] {
        return episodes
    }
}
