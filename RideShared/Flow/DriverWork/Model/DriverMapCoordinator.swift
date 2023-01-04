//
//  DriverMapCoordinator.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import Foundation
import MapKit

extension DriverMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        let parent: DriverMapViewRepresentable
        
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        init(parent: DriverMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinate = userLocation.coordinate
            let delta: CLLocationDegrees = 0.02
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: delta,
                    longitudeDelta: delta
                )
            )
            currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        
        func addAnnotation(forCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func configurePolyline(withGoalCoordinates coordinates: CLLocationCoordinate2D) {
            guard let userLocationCoordinate else {
                return //ERROROR FUTURE
            }
            getRoute(from: userLocationCoordinate, to: coordinates) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 450, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = Asset.Colors.borderColor.color
            over.lineWidth = 8
            return over
        }
        
        func getRoute(
            from userLocation: CLLocationCoordinate2D,
            to goalLocation: CLLocationCoordinate2D,
            completion: @escaping (MKRoute) -> Void
        ) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let goalPlacemark = MKPlacemark(coordinate: goalLocation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: goalPlacemark)
            let directions = MKDirections(request: request)
            directions.calculate { res, error in
                guard let route = res?.routes.first else {
                    return //ERROROOR FUTURE
                }
                completion(route)
            }
        }
        
        func clearMap() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
    }
    
}

