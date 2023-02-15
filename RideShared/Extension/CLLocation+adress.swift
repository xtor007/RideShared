//
//  CLLocation+adress.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.01.2023.
//

import Foundation
import MapKit

extension CLLocation {

    var address: String {
//        var address: String = ""
//        let geoCoder = CLGeocoder()
//        let location = self
//        //selectedLat and selectedLon are double values set by the app in a previous process
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//
//            // Address dictionary
//            //print(placeMark.addressDictionary ?? "")
//
//            // Location name
//            if let name = placeMark.addressDictionary!["Name"] as? String {
//                address += name + " "
//            }
//
//            // Street address
//            if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
//                address += street + " "
//            }
//
//            // City
//            if let city = placeMark.addressDictionary!["City"] as? String {
//                address += city + " "
//            }
//
//            // Country
//            if let country = placeMark.addressDictionary!["Country"] as? String {
//                address += country + " "
//            }
//
//        })
//
//        return address;
        return "Marata st. Shostka"
    }

}
