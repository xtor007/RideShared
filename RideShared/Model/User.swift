//
//  User.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var avatar: String?
    var rating: Double
    var tripCount: Int
    var selectionParametrs: SelectionParametrs?
    var taxiData: TaxiData?
}

extension User {
    static let preview = User(
        name: "Anatolii Khramchenko",
        email: "tolxpams@gmail.com",
        rating: 5.0,
        tripCount: 1
    )
}
