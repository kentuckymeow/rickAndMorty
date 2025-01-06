//
//  EpisodesViewModel.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//
import Foundation

final class EpisodesViewModel {
    var episodes: [Episode] = [] {
        didSet {
            onEpisodesUpdate?()
        }
    }
    
    var errorMessage: String? {
        didSet {
            onError?()
        }
    }
    
    var onEpisodesUpdate: (() -> Void)?
    var onError: (() -> Void)?
    
    func fetchEpisodes() {
        NetworkService.shared.fetch(endpoint: .episode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let decodedResponse = try JSONDecoder().decode(EpisodesResponse.self, from: data)
                        self?.episodes = decodedResponse.results
                    } catch {
                        self?.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    }
                case .failure(let error):
                    self?.errorMessage = "Request failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

