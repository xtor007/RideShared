//
//  NetworkManager+UserSideTrip.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import Foundation

extension NetworkManager {
    
    func getDriver(user: User, way: SharedWay, callback: @escaping (Result<User, Error>) -> Void) {
        generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                self.createRequest(withToken: success, link: ServerPath.getDriver.path, method: "POST") { result in
                    switch result {
                    case .success(let success):
                        do {
                            let postData = try JSONEncoder().encode(way)
                            self.makeRequest(request: success, postData: postData, callback: callback)
                        } catch {
                            callback(.failure(error))
                        }
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
