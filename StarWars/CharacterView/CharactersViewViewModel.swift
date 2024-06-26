//
//  CharactersViewViewModel.swift
//  StarWars
//
//  Created by Владислав Соколов on 04.06.2024.
//

import SwiftUI

final class CharactersViewViewModel: ObservableObject {
    @Published var characters: [CharacterImage] = []
    @Published var currentPage = 1
    
    private let networkManager = NetworkManager.shared
    private let totalPage = 952
    
    func isFirstPage() -> Bool {
        currentPage == 1
    }
    
    func isLastPage() -> Bool {
        currentPage == totalPage
    }
    
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
    
    func fetchNextPageCharacter() {
        guard currentPage < totalPage else { return }
        fetchCharacters(for: currentPage + 1)
    }
    
    func fetchPrevPageCharacter() {
        guard currentPage > 1 else { return }
        fetchCharacters(for: currentPage - 1)
    }
    
    private func fetchCharacters(for page: Int) {
        guard let url = URL(string: "\(Link.characterImageUrl.url.absoluteString)?page=\(page)&limit=10") else {
            print(NetworkError.invalidURL)
            return
        }
        
        networkManager.fetch(CharacterImages.self, from: url) { [weak self] result in
            switch result {
            case .success(let charactersData):
                DispatchQueue.main.async {
                    self?.characters = charactersData.data
                    self?.currentPage = page
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
