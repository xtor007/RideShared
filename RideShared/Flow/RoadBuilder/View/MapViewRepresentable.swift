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
        switch roadBuilderModel.state {
        case .clear:
            context.coordinator.clearMap()
        case .buildRoad, .confirmDriver:
            context.coordinator.clearMap()
            if let coordinate = searchLocationViewModel.location?.coordinate {
                context.coordinator.addAnnotation(forCoordinate: coordinate)
                context.coordinator.configurePolyline(withGoalCoordinates: coordinate)
            }
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}
