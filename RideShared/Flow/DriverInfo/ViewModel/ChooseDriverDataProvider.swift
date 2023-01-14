//
//  ChooseDriverDataProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import SwiftUI

class ChooseDriverDataProvider {

    func saveDriverData(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.requestDriverPermission(user: user) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    private func requestDriverPermission(user: User, callback: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(
                    withToken: success, link: ServerPath.driverConfirmed.path
                ) { result in
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
