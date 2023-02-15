//
//  NetworkManager+Driver.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 29.12.2022.
//

import Foundation

extension NetworkManager {
    
    func requestDriverPermission(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                guard let userData = try? JSONEncoder().encode(["idToken": success]) else {
                    callback(.failure(NetworkError.failedData()))
                    return
                }
                self.createRequest(withToken: success, link: ServerPath.driverConfirmed.path) { result in
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
