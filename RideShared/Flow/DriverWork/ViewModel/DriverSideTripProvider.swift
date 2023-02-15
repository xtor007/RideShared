//
//  DriverSideTripProvider.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 07.01.2023.
//

import Foundation

class DriverSideTripProvider {

    private let semaphore = DispatchSemaphore(value: 0)
    private var isWorking = true

    func getClient(user: User, location: SharedLocation, callback: @escaping (Result<User, Error>) -> Void) {
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

    func confirmClient(user: User, searchData: SearchClientData, callback: @escaping (Result<TripID, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.getID(user: user, searchData: searchData) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    func sendLocation(location: DriverLocation, callback: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.postLocation(location: location) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    func getRoadData(id: UUID, callback: @escaping (SharedWay) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: .background).async {
            var way: SharedWay?
            while way == nil {
                self.getWay(id: id) { result in
                    switch result {
                    case .success(let success):
                        way = success
                        semaphore.signal()
                    case .failure:
                        semaphore.signal()
                        return
                    }
                }
                semaphore.wait()
            }
            DispatchQueue.main.async {
                callback(way!)
            }
        }
    }

    func setRating(clientRating: Rating, callback: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.postRating(clientRating: clientRating) { result in
                DispatchQueue.main.async {
                    callback(result)
                }
            }
        }
    }

    private func postRating(clientRating: Rating, callback: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: ServerPath.postRating.path) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let postData = try JSONEncoder().encode(clientRating)
            NetworkManager.shared.makeRequest(request: request, postData: postData, callback: callback)
        } catch {
            callback(.failure(error))
        }
    }

    private func getWay(id: UUID, callback: @escaping (Result<SharedWay, Error>) -> Void) {
        guard let url = URL(string: ServerPath.getWay.path) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let postData = try JSONEncoder().encode(id)
            NetworkManager.shared.makeRequest(request: request, postData: postData, callback: callback)
        } catch {
            callback(.failure(error))
        }
    }

    private func postLocation(location: DriverLocation, callback: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: ServerPath.postDriverLocation.path) else {
            callback(.failure(NetworkError.failedURL()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let postData = try JSONEncoder().encode(location)
            NetworkManager.shared.makeRequest(request: request, postData: postData, callback: callback)
        } catch {
            callback(.failure(error))
        }
    }

    private func getID(user: User, searchData: SearchClientData, callback: @escaping (Result<TripID, Error>) -> Void) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(
                    withToken: success,
                    link: ServerPath.confirmClient.path,
                    method: "POST"
                ) { result in
                    switch result {
                    case .success(let success):
                        var request = success
                        request.timeoutInterval = 100
                        do {
                            let postData = try encoder.encode(searchData)
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

    private func sendWorkRequest(
        user: User,
        location: SharedLocation,
        callback: @escaping (Result<OptionalUser, Error>) -> Void
    ) {
        NetworkManager.shared.generateUserToken(user: user) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.createRequest(
                    withToken: success,
                    link: ServerPath.getClient.path,
                    method: "POST"
                ) { result in
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
