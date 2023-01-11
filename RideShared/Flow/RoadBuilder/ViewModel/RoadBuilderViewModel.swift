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
    @Published var driverLocation: SharedLocation?
    @Published var willShowingSearchView = false
    @Published var state: RoadViewState = .clear
    @Published var isLoadingInConfirmRoad = false
    
    let provider = UserSideTripProvider()
    
    var finalLocation: LocationWithTitle?
    var price: Double?
    var id: UUID?
    
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
        price = PriceManager.shared.getPrice(forDistance: distance)
        return price!
    }
    
    func confirmRoad(location: LocationWithTitle?, user: User) {
        isLoadingInConfirmRoad = true
        finalLocation = location
        provider.confirmWay(
            userLocation: userLocation,
            goalLocation: location?.coordinate,
            user: user
        ) { result in
            switch result {
            case .success(let success):
                self.state = .confirmDriver
                self.driver = success
                self.isLoadingInConfirmRoad = false
            case .failure(_):
                self.isLoadingInConfirmRoad = false
            }
        }
    }
    
    func confirmDriver(isConfirmed: Bool, forUser user: User) {
        if isConfirmed {
            if let driver, let userLocation, let finalLocation, let price {
                provider.confirmDriver(
                    user: user,
                    searchData: SearchDriverData(
                        driver: driver,
                        way: SharedWay(
                            start: SharedLocation(latitude: userLocation.latitude, longitude: userLocation.longitude, description: LocationManager.shared.locationAdress),
                            finish: SharedLocation(latitude: finalLocation.coordinate.latitude, longitude: finalLocation.coordinate.longitude, description: finalLocation.title)
                        ),
                        price: price
                    )
                ) { result in
                    switch result {
                    case .success(let success):
                        guard let id = success.id else {
                            self.state = .buildRoad
                            return
                        }
                        self.id = id
                        self.state = .road
                        self.observeDriverLocation()
                    case .failure(_):
                        self.state = .buildRoad
                    }
                }
            }
        } else {
            state = .buildRoad
            //CODE
        }
    }
    
    private func observeDriverLocation() {
        if let id {
            provider.observeDriverLocation(tripID: id) { result in
                switch result {
                case .success(let success):
                    withAnimation {
                        self.driverLocation = success
                    }
                case .failure(_):
                    return
                }
            }
        }
    }
    
}
