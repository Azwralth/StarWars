//
//  NetworkManagerAsyncAwait.swift
//  StarWars
//
//  Created by Владислав Соколов on 06.01.2025.
//

import SwiftUI

protocol TestServerApi {
    func fetch<T: Decodable>(_ type: T.Type , url: URL?) async throws -> T
    func fetchImage(url: URL?) async throws -> UIImage
}

final class NetworkManagerAsyncAwait: TestServerApi {
    func fetch<T: Decodable>(_ type: T.Type, url: URL?) async throws -> T {
        guard let url else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodeData = try JSONDecoder().decode(T.self, from: data)
            return decodeData
        } catch {
            throw NetworkError.noData
        }
    }
    
    func fetchImage(url: URL?) async throws -> UIImage {
        guard let url else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.noData
        }
        
        return image
    }
}
