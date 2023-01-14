//
//  Trip.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 08.01.2023.
//

import Foundation

struct Trip: Codable, Hashable {
    var driverEmail: String
    var clientEmail: String
    var status: Int
    var date: Date
    var clientRating: Double?
    var rating: Double?
    var music: Double?
    var speed: Double?
    var start: String?
    var finish: String?
    var price: Double?
}

extension Trip {
    static let preview = Trip(
        driverEmail: "driver@m.com",
        clientEmail: "client@m.com",
        status: 1,
        date: .now,
        start: "A",
        finish: "B",
        price: 40
    )
}
