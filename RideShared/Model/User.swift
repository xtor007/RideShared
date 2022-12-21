//
//  User.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import Foundation

struct User {
    var selectionParametrs: SelectionParametrs?
    var avatar: Data?
    var name: String
    var rating: Double
}

extension User {
    static let preview = User(
        name: "Anatolii Khramchenko",
        rating: 5.0
    )
}
