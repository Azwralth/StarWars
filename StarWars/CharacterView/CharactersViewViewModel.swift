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
    
    private let commandInvoker = CommandInvoker()
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
        let fetchCommand = FetchCharactersCommand(
            page: page,
            networkManager: networkManager) { [weak self] characters in
                self?.characters = characters
                self?.currentPage = page
            } error: { error in
                print(error.localizedDescription)
            }
        
        commandInvoker.addCommand(fetchCommand)
        commandInvoker.executeCommands()
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
