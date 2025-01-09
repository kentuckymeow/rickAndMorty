//
//  Character.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import Foundation

struct Character: Codable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: SingleLocation
    let image: String
    let episode: [Episode]
    let url: String
    let created: String
//    enum CodingKeys: String, CodingKey{
//        case id
//        case name
//        case status
//        case species
//        case type
//        case gender
//        case origin
//        case location
//        case image
//        case episode
//        case url
//        case created
//    }
}

struct CharacterResponce: Codable {
    let info: Info
    let results: [Character]
}

