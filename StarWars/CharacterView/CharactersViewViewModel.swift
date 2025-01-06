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
    
    private let networkManager: ServerApi
    private let totalPage = 952
    
    init(networkManager: ServerApi) {
        self.networkManager = networkManager
        fetchCharacters()
    }
    
    func isFirstPage() -> Bool {
        currentPage == 1
    }
    
    func isLastPage() -> Bool {
        currentPage == totalPage
    }
    
    func fetchCharacters(from page: Int = 1) {
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
    
    func fetchNextPageCharacter() {
        guard currentPage < totalPage else { return }
        fetchCharacters(from: currentPage + 1)
    }
    
    func fetchPrevPageCharacter() {
        guard currentPage > 1 else { return }
        fetchCharacters(from: currentPage - 1)
    }
}
