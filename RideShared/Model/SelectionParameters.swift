//
//  SelectionParameters.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 20.12.2022.
//

import Foundation

struct SelectionParametrs: Codable {
    var musicalPreferences: String?
    var musicalPrioritet: Int
    var driverGenderIndex: Int?
    var genderPrioritet: Int
    var driverMinAge: Int?
    var driverMaxAge: Int?
    var agePrioritet: Int
    var speedIndex: Int?
    var speedPrioritet: Int
    var carColorIndex: Int?
    var colorPrioritet: Int
}

extension SelectionParametrs {
    func getPriorities() -> [Int] {
        return [
            musicalPrioritet,
            genderPrioritet,
            agePrioritet,
            speedPrioritet,
            colorPrioritet
        ]
    }
}
