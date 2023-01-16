//
//  MapViewRepresentable.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {

    @EnvironmentObject var roadBuilderModel: RoadBuilderViewModel
    @EnvironmentObject var searchLocationViewModel: SearchLocationViewModel

    let mapView = MKMapView()
    let locationManager = LocationManager.shared

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.userLocationCoordinate = roadBuilderModel.userLocation
        switch roadBuilderModel.state {
        case .clear, .ended:
            context.coordinator.clearMap()
        case .buildRoad, .confirmDriver:
            context.coordinator.clearMap()
            if let coordinate = searchLocationViewModel.location?.coordinate {
                context.coordinator.addAnnotation(forCoordinate: coordinate)
                context.coordinator.configurePolyline(withGoalCoordinates: coordinate)
            }
        case .road:
            context.coordinator.clearMap()
            if let finishCoordinate = searchLocationViewModel.location?.coordinate {
                context.coordinator.addAnnotation(forCoordinate: finishCoordinate)
                context.coordinator.configurePolyline(withGoalCoordinates: finishCoordinate)
            }
        }
    }

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }

}
