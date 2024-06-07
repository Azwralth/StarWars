//
//  DetailViewViewModel.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import Foundation

class DetailViewViewModel: ObservableObject {
    @Published var character: CharacterData?
    
    private let networkManager = NetworkManager.shared
    
    func fetchCharacter(searchName: String) {
        guard let url = URL(string: "https://swapi.dev/api/people/?search=\(searchName)") else {
            print("Invalid URL")
            return
        }
        
        networkManager.fetch(CharactersData.self, from: url) { [weak self] result in
            switch result {
            case .success(let characterData):
                DispatchQueue.main.async {
                    self?.character = characterData.results.first
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
