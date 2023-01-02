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
    @Published var selectedLocation: String? {
        didSet {
            
        }
    }
    
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
    
}
