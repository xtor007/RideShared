//
//  NetworkManager+Token.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 29.12.2022.
//

import Foundation

extension NetworkManager {
    
    func generateUserToken(user: User, callback: @escaping (Result<String, Error>) -> Void) {
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
    
    func createRequest(withToken token: String, link: String, method: String = "POST", callback: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let url = URL(string:  link) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        callback(.success(request))
    }
    
}
