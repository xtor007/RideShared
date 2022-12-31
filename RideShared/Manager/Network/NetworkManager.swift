//
//  NetworkManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import SwiftUI

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func loadImage(link: String, callback: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: link) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        do {
            let avatarData = try Data(contentsOf: url)
            if let avatar = UIImage(data: avatarData) {
                callback(.success(avatar))
            } else {
                callback(.failure(NetworkError.failedData()))
            }
        }
        catch {
            callback(.failure(error))
        }
    }
    
    func makeRequest<GetType: Decodable>(request: URLRequest, postData: Data? = nil, callback: @escaping (Result<GetType, Error>) -> Void) {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        URLSession.shared.uploadTask(with: request, from: postData) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                callback(.failure(error!))
                return
            }
            do {
                if response.statusCode == 200 {
                    let result = try decoder.decode(GetType.self, from: data)
                    callback(.success(result))
                } else {
                    callback(.failure(NetworkError.serverError()))
                }
            }
            catch {
                callback(.failure(error))
            }
        }.resume()
    }
    
    func makePostRequest(request: URLRequest, postData: Data, callback: @escaping (Result<Void, Error>) -> Void) {
        URLSession.shared.uploadTask(with: request, from: postData) { _, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(.failure(error!))
                return
            }
            if response.statusCode == 200 {
                callback(.success(()))
            } else {
                callback(.failure(NetworkError.serverError()))
            }
        }.resume()
    }
    
}
