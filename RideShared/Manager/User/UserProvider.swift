//
//  UserProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import SwiftUI

class UserProvider {

    func updateUser(newValue: User, callback: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.updateUser(user: newValue) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    func loadAvatar(link: String, callback: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            NetworkManager.shared.loadImage(link: link) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    private func updateUser(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(withToken: success, link: ServerPath.updateUser.path) { result in
                    switch result {
                    case .success(let success):
                        NetworkManager.shared.makeRequest(request: success, callback: callback)
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
