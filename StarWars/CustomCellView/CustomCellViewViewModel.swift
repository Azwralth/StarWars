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
    
    private let networkManager: TestServerApi
    
    init(character: CharacterImage, networkManager: TestServerApi) {
        self.character = character
        self.networkManager = networkManager
    }
    
    func fetchImage(from url: String) async {
        guard let imageUrl = URL(string: url) else { return }
        do {
            let imageData = try await networkManager.fetchImage(url: imageUrl)
            DispatchQueue.main.async { [weak self] in
                self?.image = imageData
            }
        } catch {
            print("failed to fetch image")
            image = UIImage(systemName: "exclamationmark.circle")
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
