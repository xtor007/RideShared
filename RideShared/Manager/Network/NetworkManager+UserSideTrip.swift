//
//  NetworkManager+UserSideTrip.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import Foundation

extension NetworkManager {
    
    func getDriver(user: User, callback: @escaping (Result<User, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                self.createRequest(withToken: success, link: ServerPath.getDriver.path) { result in
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
