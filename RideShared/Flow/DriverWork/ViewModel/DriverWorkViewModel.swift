//
//  DriverWorkViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import Foundation
import MapKit

class DriverWorkViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var location: LocationWithTitle?
    @Published var userLocation: CLLocationCoordinate2D? {
        didSet {
            if let userLocation, state == .toClient || state == .toFinish {
                sendLocation(location: userLocation)
                if let way, state == .toClient {
                    if abs(userLocation.longitude - way.start.longitude) < 0.001 && abs(userLocation.latitude - way.start.latitude) < 0.001 {
                        state = .toFinish
                    }
                }
                if let way, state == .toFinish {
                    if abs(userLocation.longitude - way.finish.longitude) < 0.001 && abs(userLocation.latitude - way.finish.latitude) < 0.001 {
                        state = .ended

                    }
                }
            }
        }
    }
    @Published var client: User?
    @Published var way: SharedWay?
    
    @Published var clientRating = 5.0
    
    @Published var state = DriverWorkState.notWorking
    let provider = DriverSideTripProvider()
    
    @Published var willShowError = false
    @Published var errorMessage = ""
    
    var id: UUID?
    
    func setLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(forLocalCompletion: location) { res, error in
            guard let item = res?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.location = LocationWithTitle(title: location.title, coordinate: coordinate)
        }
    }
    
    func locationSearch(forLocalCompletion localCompletion: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = localCompletion.title.appending(localCompletion.subtitle)
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
    }
    
    func searchClient(user: User) {
        if let location = userLocation {
            state = .searching
            provider.getClient(
                user: user,
                location: SharedLocation(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            ) { result in
                switch result {
                case .success(let success):
                    self.client = success
                    self.state = .confirmClient
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.willShowError = true
                    self.state = .notWorking
                }
            }
        }
    }
    
    func confirmUser(isConfirmed: Bool, forUser user: User) {
        if let client, let userLocation {
            if isConfirmed {
                provider.confirmClient(
                    user: user,
                    searchData: SearchClientData(
                        client: client,
                        location: SharedLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                    )
                ) { result in
                    switch result {
                    case .success(let success):
                        guard let id = success.id else {
                            self.state = .notWorking
                            return
                        }
                        self.id = id
                        self.provider.getRoadData(id: id) { way in
                            self.way = way
                        }
                        self.state = .toClient
                    case .failure(_):
                        self.state = .notWorking
                    }
                }
            } else {
                state = .notWorking
            }
        }
    }
    
    func sendLocation(location: CLLocationCoordinate2D) {
        if let id {
            let driverLocation = DriverLocation(
                id: id,
                location: SharedLocation(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            )
            provider.sendLocation(location: driverLocation) { _ in
                return
            }
        }
    }
    
    func finishTrip() {
        if let id {
            provider.setRating(clientRating: Rating(id: id, rating: clientRating, music: nil, speed: nil)) { result in
                switch result {
                case .success(_):
                    self.location = nil
                    self.client = nil
                    self.way = nil
                    self.clientRating = 5.0
                    self.state = .notWorking
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.willShowError = true
                }
            }
        }
    }
    
}
