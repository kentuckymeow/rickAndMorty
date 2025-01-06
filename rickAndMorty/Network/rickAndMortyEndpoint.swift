//
//  rickAndMortyEndpoint.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 05.01.2025.
//

import Foundation

enum API {
    case character
    case location
    case episode
    
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api/") else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .character: 
            return "character"
        case .location: 
            return "location"
        case .episode: 
            return "episode"
        }
    }
    
    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}


