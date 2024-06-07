//
//  Link.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import Foundation

enum Link {
    case characterUrl
    case peopleUrl
    case filmUrl
    case planetUrl
    case starshipUrl
    case searchCharacter
    
    var url: URL {
        switch self {
        case .characterUrl:
            URL(string: "https://starwars-databank-server.vercel.app/api/v1/characters?page=5&limit=10")!
        case .filmUrl:
            URL(string: "https://swapi.dev/api/films/")!
        case .planetUrl:
            URL(string: "https://swapi.dev/api/planets/")!
        case .starshipUrl:
            URL(string: "https://swapi.dev/api/starships/")!
        case .peopleUrl:
            URL(string: "https://swapi.dev/api/people/")!
        case .searchCharacter:
            URL(string: "https://swapi.dev/api/people/?search=")!
        }
    }
}
