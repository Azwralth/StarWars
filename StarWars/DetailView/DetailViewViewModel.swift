//
//  DetailViewViewModel.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import UIKit

final class DetailViewViewModel: ObservableObject {
    @Published var character: CharacterData?
    @Published var image: UIImage?
    
    let characterName: String
    let characterImage: String
    let characterDescription: String
    
    var hasCharacterDetails: Bool {
        guard let character = character else { return false }
        return !(character.birthYear.isEmpty || character.hairColor.isEmpty || character.height.isEmpty)
    }
    
    private let networkManager = NetworkManager.shared
    
    init(characterName: String, characterImage: String, characterDescription: String) {
        self.characterName = characterName
        self.characterImage = characterImage
        self.characterDescription = characterDescription
        fetchImage(from: characterImage)
    }
    
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
    
    func fetchImage(from url: String) {
        networkManager.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
