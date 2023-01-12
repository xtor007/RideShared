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
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            if let userLocation, state == .toClient || state == .toFinish {
                sendLocation(location: userLocation)
            }
        }
    }
    @Published var client: User?
    
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
    
}
