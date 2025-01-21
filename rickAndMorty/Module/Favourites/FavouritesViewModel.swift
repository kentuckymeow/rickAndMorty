//
//  FavouritesManager.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.01.2025.
//

import Foundation

protocol FavouriteViewModelDelegate: AnyObject {
    var updateHandler: (([Episode], [Character]) -> Void)? { get set }
    func addToFavourites(episode: Episode, character: Character)
    func getFavourites()
    func removeFromFavourites(episode: Episode)
    func isFavourite(episode: Episode) -> Bool
}

final class FavouritesViewModel: FavouriteViewModelDelegate {
    static let shared = FavouritesViewModel()

    var updateHandler: (([Episode], [Character]) -> Void)?
    private var favouriteEpisodes: [Episode] = []
    private var favouriteCharacters: [Character] = []

    init() {}

    func addToFavourites(episode: Episode, character: Character) {
            if !favouriteEpisodes.contains(where: { $0.id == episode.id }) {
                favouriteEpisodes.append(episode)
                print("Added episode: (episode)")
                favouriteCharacters.append(character)
                print("Added character: (character)")
            } else {
                print("Episode already exists in favourites: (episode)")
            }
            printCurrentFavourites()
            updateHandler?(favouriteEpisodes, favouriteCharacters)
        }
        
        func getFavourites() {
            print("Fetching favourites")
            printCurrentFavourites()
            updateHandler?(favouriteEpisodes, favouriteCharacters)
        }
        
        func removeFromFavourites(episode: Episode) {
            if let index = favouriteEpisodes.firstIndex(where: { $0.id == episode.id }) {
                favouriteEpisodes.remove(at: index)
                print("Removed episode: (episode)")
                favouriteCharacters.removeAll { episode.characters.contains($0.url) }
                print("Removed characters associated with episode: (episode)")
            } else {
                print("Episode not found in favourites: (episode)")
            }
            printCurrentFavourites()
            updateHandler?(favouriteEpisodes, favouriteCharacters)
        }
        func isFavourite(episode: Episode) -> Bool {
            return favouriteEpisodes.contains(where: { $0.id == episode.id })
        }
        private func printCurrentFavourites() {
            print("Current favourite episodes: (favouriteEpisodes)")
            print("Current favourite characters: (favouriteCharacters)")
    }
}
