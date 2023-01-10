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
    var userLocation: CLLocationCoordinate2D?
    @Published var client: User?
    
    @Published var state = DriverWorkState.notWorking
    let provider = DriverSideTripProvider()
    
    @Published var willShowError = false
    @Published var errorMessage = ""
    
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
    
    func confirmUser(isConfirmed: Bool) {
        if isConfirmed {
            print("GO")
        } else {
            state = .notWorking
        }
    }
    
}
