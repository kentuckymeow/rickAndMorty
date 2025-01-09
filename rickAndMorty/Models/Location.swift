//
//  Location.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 06.01.2025.
//

import Foundation

struct Location: Codable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case type
//        case dimension
//        case residents
//        case url
//        case created
//    }
}
