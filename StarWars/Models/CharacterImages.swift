//
//  CharacterImages.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import Foundation

struct CharacterImages: Decodable {
    let data: [CharacterImage]
}

struct CharacterImage: Decodable, Hashable {
    let image: String
    let name: String
    let description: String
}
