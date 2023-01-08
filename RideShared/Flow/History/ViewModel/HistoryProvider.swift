//
//  HistoryProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 08.01.2023.
//

import Foundation

class HistoryProvider {
    
    func loadTrips(forUser user: User, callback: @escaping (Result<[Trip],Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.getTripsRequest(user: user) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }
    
    private func getTripsRequest(user: User, callback: @escaping (Result<[Trip],Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(withToken: success, link: ServerPath.getAllTrips.path) { result in
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
