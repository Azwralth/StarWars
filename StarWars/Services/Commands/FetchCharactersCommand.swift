//
//  FetchCharactersCommand.swift
//  StarWars
//
//  Created by Владислав Соколов on 13.01.2025.
//

import SwiftUI

final class FetchCharactersCommand: Command {
    private let page: Int
    private let networkManager: ServerApi
    private let completion: ([CharacterImage]) -> Void
    private let error: (NetworkError) -> Void
    
    init(
        page: Int,
        networkManager: ServerApi,
        completion: @escaping ([CharacterImage]) -> Void,
        error: @escaping (NetworkError) -> Void
    ) {
        self.page = page
        self.networkManager = networkManager
        self.completion = completion
        self.error = error
    }
    
    func execute() {
        guard let url = URL(string: "\(Link.characterImageUrl.url.absoluteString)?page=\(page)&limit=10") else {
            error(.invalidURL)
            return
        }
        
        networkManager.fetch(CharacterImages.self, from: url) { result in
            switch result {
            case .success(let charactersData):
                DispatchQueue.main.async {
                    self.completion(charactersData.data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error(error)
                }
            }
        }
    }
}
