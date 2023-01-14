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
    @Published var userLocation: CLLocationCoordinate2D? {
        didSet {
            if let userLocation {
                if let finalLocation, state == .road {
                    if abs(userLocation.longitude - finalLocation.coordinate.longitude) < 0.001
                        && abs(userLocation.latitude - finalLocation.coordinate.latitude) < 0.001 {
                        provider.isDriverLocationLoading = false
                        state = .ended
                    }
                }
            }
        }
    }
    @Published var driverLocation: SharedLocation?
    @Published var willShowingSearchView = false
    @Published var state: RoadViewState = .clear
    @Published var isLoadingInConfirmRoad = false

    @Published var rating = 5.0
    @Published var musicRating = 5.0
    @Published var speedRating = 5.0

    @Published var willShowError = false
    @Published var errorMessage = ""

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
            case .failure:
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
                            start: SharedLocation(
                                latitude: userLocation.latitude,
                                longitude: userLocation.longitude,
                                description: LocationManager.shared.locationAdress
                            ),
                            finish: SharedLocation(
                                latitude: finalLocation.coordinate.latitude,
                                longitude: finalLocation.coordinate.longitude,
                                description: finalLocation.title
                            )
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
                    case .failure:
                        self.state = .buildRoad
                    }
                }
            }
        } else {
            state = .buildRoad
        }
    }

    func finishTrip() {
        if let id {
            provider.setRating(rating: Rating(
                id: id, rating: rating,
                music: musicRating,
                speed: speedRating
            )) { result in
                switch result {
                case .success:
                    self.driver = nil
                    self.driverLocation = nil
                    self.willShowingSearchView = false
                    self.isLoadingInConfirmRoad = false
                    self.rating = 5.0
                    self.musicRating = 5.0
                    self.speedRating = 5.0
                    self.state = .clear
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.willShowError = true
                }
            }
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
                case .failure:
                    return
                }
            }
        }
    }

}
