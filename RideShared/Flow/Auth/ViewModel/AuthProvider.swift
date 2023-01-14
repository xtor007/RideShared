//
//  AuthProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import SwiftUI

class AuthProvider {

    func signIn(manager: AuthManager, rootViewController: UIViewController,
                callback: @escaping (Result<User, Error>) -> Void) {
        manager.singIn(rootViewController: rootViewController) { result in
            switch result {
            case .success(let success):
                success.user.refreshTokensIfNeeded { user, error in
                    if let error {
                        callback(.failure(error))
                        return
                    }
                    DispatchQueue.global(qos: .background).async {
                        self.auth(token: user!.idToken!.tokenString, callback: callback)
                    }
                }
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }

    private func auth(token: String, callback: @escaping (Result<User, Error>) -> Void) {
        NetworkManager.shared.createRequest(withToken: token, link: ServerPath.singIn.path) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.makeRequest(request: success, callback: callback)
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }

}
