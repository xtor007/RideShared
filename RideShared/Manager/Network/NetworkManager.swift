//
//  NetworkManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func auth(token: String, callback: @escaping (Result<User, Error>) -> Void) {
        guard let authData = try? JSONEncoder().encode(["idToken": token]) else {
            return
        }
        postRequest(postData: authData, path: .singIn, callback: callback)
    }
    
    private func postRequest<GetType>(postData: Data, path: ServerPath, callback: @escaping (Result<GetType, Error>) -> Void) {
        guard let url = URL(string: ProcessInfo.processInfo.environment[EnviromentVariables.serverURL]! + path.path) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.uploadTask(with: request, from: postData) { data, response, error in
            // Handle response from your backend.
            if let data {
                print(String(data: data, encoding: .ascii))
            }
        }.resume()
    }
    
}
