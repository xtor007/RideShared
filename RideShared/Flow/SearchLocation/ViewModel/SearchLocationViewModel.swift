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
    
    private let searchCompleter = MKLocalSearchCompleter()
    var locationName = "" {
        didSet {
            searchCompleter.queryFragment = locationName
        }
    }
    
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
            print(self.location)
        }
    }
    
    func locationSearch(forLocalCompletion localCompletion: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = localCompletion.title.appending(localCompletion.subtitle)
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
    }
    
}
