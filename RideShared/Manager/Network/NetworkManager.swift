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
    
    func updateUser(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                guard let userData = try? JSONEncoder().encode(["idToken": success]) else {
                    callback(.failure(NetworkError.failedData()))
                    return
                }
                guard let url = URL(string:  ServerPath.updateUser.path) else {
                    callback(.failure(NetworkError.failedURL()))
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue( "Bearer \(success)", forHTTPHeaderField: "Authorization")
                self.makePostRequest(request: request, postData: userData, callback: callback)
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
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
            }
        }
        catch {
            callback(.failure(error))
        }
    }
    
    private func generateUserToken(user: User, callback: @escaping (Result<String, Error>) -> Void) {
        do {
            let jsonUser = try JSONEncoder().encode(user)
            let base64UrlEncodedJson = jsonUser.base64EncodedString()
            let header = """
            {
                "alg": "HS256",
                "typ": "JWT"
            }
            """.data(using: .utf8)?.base64EncodedString()
            if let header {
                callback(.success("\(header).\(base64UrlEncodedJson)"))
            } else {
                callback(.failure(NetworkError.codeFailed()))
            }
        } catch {
            callback(.failure(error))
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
    
    private func makePostRequest(request: URLRequest, postData: Data, callback: @escaping (Result<Void, Error>) -> Void) {
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
