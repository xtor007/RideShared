//
//  PriceManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 03.01.2023.
//

import Foundation

class PriceManager {

    static let shared = PriceManager()

    let tarif = 6.0 / 1000
    let base = 40.0

    private init() {}

    func getPrice(forDistance distance: Double) -> Double {
        return distance * tarif + base
    }

}
