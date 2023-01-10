//
//  File.swift
//  
//
//  Created by Anatoliy Khramchenko on 10.01.2023.
//

import Foundation

struct SearchDriverData: Codable {
    let driver: User
    let way: SharedWay
    let price: Double
}
