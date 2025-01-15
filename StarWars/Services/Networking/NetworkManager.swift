//
//  NetworkManager.swift
//  StarWars
//
//  Created by Владислав Соколов on 07.06.2024.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol ServerApi {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping(Result<T, NetworkError>) -> Void)
    func fetchImage(from url: String?, completion: @escaping(Result<UIImage, NetworkError>) -> Void)
}

final class NetworkManager: ServerApi {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }.resume()
    }
}
