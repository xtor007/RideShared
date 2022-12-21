//
//  Double+rating.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import Foundation

extension Double {
    var rating: String {
        return String("\(self)".prefix(3))
    }
}
