//
//  LocationManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
    
}
