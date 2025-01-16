//
//  Character.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import Foundation

struct Episode: Codable, Hashable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    var characters: [String]
    let url: String
    let created: String
}

struct EpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}
