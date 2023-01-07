//
//  DriverSideTripProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 07.01.2023.
//

import Foundation
import SocketIO

class DriverSideTripProvider {
    
    private let semaphore = DispatchSemaphore(value: 0)
    private var isWorking = true
    
    func getClient(user: User, location: SharedLocation, callback: @escaping (Result<User,Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.isWorking = true
            while self.isWorking {
                self.sendWorkRequest(user: user, location: location) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            if let user = success.user {
                                callback(.success(user))
                                self.isWorking = false
                            }
                        case .failure(let failure):
                            callback(.failure(failure))
                            self.isWorking = false
                        }
                        self.semaphore.signal()
                    }
                }
                self.semaphore.wait()
            }
            if self.isWorking {
                callback(.failure(NetworkError.serverError()))
            }
        }
    }
    
    func cancelSearching() {
        isWorking = false
        semaphore.signal()
    }
    
    private func sendWorkRequest(user: User, location: SharedLocation, callback: @escaping (Result<OptionalUser,Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(withToken: success, link: ServerPath.getClient.path, method: "POST") { result in
                    switch result {
                    case .success(let success):
                        var request = success
                        request.timeoutInterval = 100
                        do {
                            let postData = try JSONEncoder().encode(location)
                            NetworkManager.shared.makeRequest(request: request, postData: postData, callback: callback)
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
