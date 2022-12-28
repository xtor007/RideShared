//
//  TaxiData.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

struct TaxiData: Codable {
    var taxiTripCount: Int
    var musicRating: Double
    var genderIndex: Int
    var dateOfBirth: Date
    var speedRating: Double
    var yourCarColorIndex: Int
}
