//
//  DriverMapViewRepresentable.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import SwiftUI
import MapKit

struct DriverMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var state: DriverWorkState
    @EnvironmentObject var driverWorkModel: DriverWorkViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        switch state {
//        case .clear:
//            context.coordinator.clearMap()
//        case .buildRoad:
//            context.coordinator.clearMap()
//            if let coordinate = searchLocationModel.location?.coordinate {
//                context.coordinator.addAnnotation(forCoordinate: coordinate)
//                context.coordinator.configurePolyline(withGoalCoordinates: coordinate)
//            }
//        }
        print("OK")
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}
