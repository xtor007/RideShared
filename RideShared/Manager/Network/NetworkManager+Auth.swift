//
//  NetworkManager+Auth.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 29.12.2022.
//

import Foundation

extension NetworkManager {
    
    func auth(token: String, callback: @escaping (Result<User, Error>) -> Void) {
        guard let authData = try? JSONEncoder().encode(["idToken": token]) else {
            callback(.failure(NetworkError.failedData()))
            return
        }
        createRequest(withToken: token, link: ServerPath.singIn.path) { result in
            switch result {
            case .success(let success):
                self.makeRequest(request: success, postData: authData, callback: callback)
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func updateUser(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                guard let userData = try? JSONEncoder().encode(["idToken": success]) else {
                    callback(.failure(NetworkError.failedData()))
                    return
                }
                self.createRequest(withToken: success, link: ServerPath.updateUser.path) { result in
                    switch result {
                    case .success(let success):
                        self.makePostRequest(request: success, postData: userData, callback: callback)
                    case .failure(let failure):
                        callback(.failure(failure))
                    }
                }
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
}
