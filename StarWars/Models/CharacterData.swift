//
//  CharacterData.swift
//  StarWars
//
//  Created by Владислав Соколов on 05.06.2024.
//

import Foundation

struct CharactersData: Decodable {
    let results: [CharacterData]
}

struct CharacterData: Decodable, Hashable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let birthYear: String
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case birthYear = "birth_year"
        case weight
    }
}
