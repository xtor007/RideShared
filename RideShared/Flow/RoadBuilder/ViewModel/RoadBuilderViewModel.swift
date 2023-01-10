//
//  RoadBuilderViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 10.01.2023.
//

import SwiftUI
import MapKit

class RoadBuilderViewModel: ObservableObject {
    
    @Published var driver: User?
    var userLocation: CLLocationCoordinate2D?
    
    @Published var willShowingSearchView = false
    @Published var state: RoadViewState = .clear
    @Published var isLoadingInConfirmRoad = false
    
    let provider = UserSideTripProvider()
    
    func computePrice(forLocation location: LocationWithTitle?) -> Double {
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
    
    func confirmRoad(location: LocationWithTitle?, user: User) {
        isLoadingInConfirmRoad = true
        provider.confirmWay(
            userLocation: userLocation,
            goalLocation: location?.coordinate,
            user: user
        ) { result in
            switch result {
            case .success(let success):
                self.state = .confirmDriver
                self.driver = success
            case .failure(_):
                self.isLoadingInConfirmRoad = false
            }
        }
    }
    
    func confirmDriver(isConfirmed: Bool) {
        if isConfirmed {
            print("GO")
        } else {
            state = .buildRoad
            //CODE
        }
    }
    
}
