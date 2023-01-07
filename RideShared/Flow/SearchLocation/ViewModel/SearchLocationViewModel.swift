//
//  SearchLocationViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import Foundation
import MapKit

class SearchLocationViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var locations = [MKLocalSearchCompletion]()
    @Published var location: LocationWithTitle?
    @Published var driver: User?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var locationName = "" {
        didSet {
            searchCompleter.queryFragment = locationName
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = locationName
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        locations = completer.results
    }
    
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
    
    func computePrice() -> Double {
        guard let goalLocation = location?.coordinate else {
            return 0
        }
        guard let userLocation else {
            return 0
        }
        let userLocationPoint = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let goalLocationPoint = CLLocation(latitude: goalLocation.latitude, longitude: goalLocation.longitude)
        let distance = userLocationPoint.distance(from: goalLocationPoint)
        return PriceManager.shared.getPrice(forDistance: distance)
    }
    
}
