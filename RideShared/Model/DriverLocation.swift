//
//  File.swift
//  
//
//  Created by Anatoliy Khramchenko on 10.01.2023.
//

import Foundation

struct DriverLocation: Codable {
    let id: UUID
    let location: SharedLocation
}
