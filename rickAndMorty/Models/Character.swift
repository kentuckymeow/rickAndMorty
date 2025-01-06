//
//  Character.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let status: CharacterStatus?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: SingleLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct CharacterResponce: Codable {
    let info: Info
    let results: [Character]
}

