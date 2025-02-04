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
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: SingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterResponce: Codable {
    let info: Info
    let results: [Character]
}
extension Character {
    static func defaultCharacter() -> Character {
        return Character(id: 0, name: "Unknown", status: "Unknown", species: "Unknown", type: "", gender: "Unknown",origin: Origin(name: "", url: "") ,location: SingleLocation(name: "Unknown", url: ""), image: "", episode: [], url: "", created: "")
    }
}


