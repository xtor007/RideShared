//
//  NetworkManager+Auth.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 29.12.2022.
//

import Foundation

extension NetworkManager {
    
    func updateUser(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                self.createRequest(withToken: success, link: ServerPath.updateUser.path) { result in
                    switch result {
                    case .success(let success):
                        self.makeRequest(request: success, callback: callback)
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
