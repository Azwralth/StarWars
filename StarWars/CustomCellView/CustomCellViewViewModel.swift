//
//  CustomCellViewViewModel.swift
//  StarWars
//
//  Created by Владислав Соколов on 10.06.2024.
//

import SwiftUI

final class CustomCellViewViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var avatarRotationDegrees = 0.0
    @Published var character: CharacterImage?
    
    private let networkManager = NetworkManager.shared
    
    init(character: CharacterImage) {
        self.character = character
        self.fetchImage(from: character.image)
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
    
    func startAvatarRotation() {
        DispatchQueue.main.async { [weak self] in
            withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                self?.avatarRotationDegrees = 360
            }
        }
    }
}
