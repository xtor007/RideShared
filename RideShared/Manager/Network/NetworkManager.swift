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
    
    func auth(token: String, callback: @escaping (Result<User, Error>) -> Void) {
        guard let authData = try? JSONEncoder().encode(["idToken": token]) else {
            callback(.failure(NetworkError.failedData()))
            return
        }
        guard let url = URL(string:  ServerPath.singIn.path) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        makeRequest(request: request, postData: authData, callback: callback)
    }
    
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
                print(2)
            }
        }
        catch {
            callback(.failure(error))
            print(error)
        }
    }
    
    private func makeRequest<GetType: Decodable>(request: URLRequest, postData: Data? = nil, callback: @escaping (Result<GetType, Error>) -> Void) {
        URLSession.shared.uploadTask(with: request, from: postData) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                callback(.failure(error!))
                return
            }
            do {
                if response.statusCode == 200 {
                    let result = try JSONDecoder().decode(GetType.self, from: data)
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
    
}
