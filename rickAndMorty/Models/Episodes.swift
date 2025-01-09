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
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case air_date = "air_date"
//        case episode = "episode"
//        case characters = "characters"
//        case url = "url"
//        case created = "created"
//    }
}

struct EpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}
