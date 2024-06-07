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
    let gender: String
}
