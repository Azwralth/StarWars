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
    
    private let networkManager: TestServerApi
    
    init(characterName: String, characterImage: String, characterDescription: String, networkManager: TestServerApi) {
        self.characterName = characterName
        self.characterImage = characterImage
        self.characterDescription = characterDescription
        self.networkManager = networkManager
    }
    
    func fetchCharacter(searchName: String) async {
        guard let url = URL(string: "\(Link.searchCharacter)\(searchName)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let characterData = try await networkManager.fetch(CharactersData.self, url: url)
            DispatchQueue.main.async { [weak self] in
                self?.character = characterData.results.first
            }
        } catch {
            print("failed to fetch detail character")
        }
    }
    
    func fetchImage(from url: String) async {
        do {
            let imageData = try await networkManager.fetchImage(url: URL(string: url))
            DispatchQueue.main.async { [weak self] in
                self?.image = imageData
            }
        } catch {
            print("failed to fetch image")
        }
    }
}
