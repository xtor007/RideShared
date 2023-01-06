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
    
}
