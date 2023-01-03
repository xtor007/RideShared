//
//  MapViewRepresentable.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var state: RoadViewState
    @EnvironmentObject var searchLocationModel: SearchLocationViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch state {
        case .clear:
            context.coordinator.clearMap()
        case .buildRoad:
            context.coordinator.clearMap()
            if let coordinate = searchLocationModel.selectedLocationCoordinate {
                context.coordinator.addAnnotation(forCoordinate: coordinate)
                context.coordinator.configurePolyline(withGoalCoordinates: coordinate)
            }
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}
