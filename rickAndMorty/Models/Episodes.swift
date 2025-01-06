//
//  Character.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import Foundation

struct Episode: Codable {
    let id: Int?
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [Character]
    let url: String?
    let created: String?
}

struct EpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}
