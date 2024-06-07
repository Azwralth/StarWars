//
//  CharactersViewViewModel.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

class CharactersViewViewModel: ObservableObject {
    @Published var characters: [CharacterImage] = []
    @Published var avatarRotationDegrees = 0.0
    
    private let networkManager = NetworkManager.shared
    
    func fetchCharacters(from url: URL) {
        networkManager.fetch(CharacterImages.self, from: url) { [weak self] result in
            switch result {
            case .success(let charactersData):
                DispatchQueue.main.async {
                    self?.characters = charactersData.data
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func startAvatarRotation() {
        DispatchQueue.main.async { [weak self] in
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                self?.avatarRotationDegrees = 360
            }
        }
    }
}
