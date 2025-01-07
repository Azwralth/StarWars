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
    
    private let networkManager: TestServerApi
    private let totalPage = 952
    
    init(networkManager: TestServerApi) {
        self.networkManager = networkManager
    }
    
    func isFirstPage() -> Bool {
        currentPage == 1
    }
    
    func isLastPage() -> Bool {
        currentPage == totalPage
    }
    
    func fetchCharacters(from page: Int) async {
        guard let url = URL(string: "\(Link.characterImageUrl.url.absoluteString)?page=\(page)&limit=10") else {
            print(NetworkError.invalidURL)
            return
        }
        
        do {
            let characterData = try await networkManager.fetch(CharacterImages.self, url: url)
            DispatchQueue.main.async { [weak self] in
                self?.characters = characterData.data
                self?.currentPage = page
            }
        } catch {
            print("failed to fetch characters")
        }
    }
    
    func fetchNextPageCharacter() async {
        guard currentPage < totalPage else { return }
        await fetchCharacters(from: currentPage + 1)
    }
    
    func fetchPrevPageCharacter() async {
        guard currentPage > 1 else { return }
        await fetchCharacters(from: currentPage - 1)
    }
}
