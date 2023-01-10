//
//  UserSideTripProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import Foundation
import MapKit

class UserSideTripProvider {
    
    func confirmWay(userLocation: CLLocationCoordinate2D?, goalLocation: CLLocationCoordinate2D?, user: User, callback: @escaping (Result<User,Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let startCoordinate = userLocation else {
                return
            }
            guard let finishCoordinate = goalLocation else {
                return
            }
            self.getDriver(
                user: user,
                way: SharedWay(
                    start: SharedLocation(
                        latitude: startCoordinate.latitude,
                        longitude: startCoordinate.longitude
                    ),
                    finish: SharedLocation(
                        latitude: finishCoordinate.latitude,
                        longitude: finishCoordinate.longitude
                    )
                )
            ) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }
    
    private func getDriver(user: User, way: SharedWay, callback: @escaping (Result<User, Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(withToken: success, link: ServerPath.getDriver.path, method: "POST") { result in
                    switch result {
                    case .success(let success):
                        do {
                            let postData = try JSONEncoder().encode(way)
                            NetworkManager.shared.makeRequest(request: success, postData: postData, callback: callback)
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