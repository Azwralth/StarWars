//
//  CharacterImages.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import Foundation

struct CharacterImages: Decodable {
    let info: Info
    let data: [CharacterImage]
}

struct CharacterImage: Decodable, Hashable {
    let image: String
    let name: String
    let description: String
}

struct Info: Decodable, Hashable {
    let total: Int
    let page: Int
    let limit: Int
    let next: String
//    let prev: Int
}
