//
//  File.swift
//  
//
//  Created by Anatoliy Khramchenko on 10.01.2023.
//

import Foundation

struct Rating: Codable {
    let id: UUID
    let rating: Double
    let music: Double?
    let speed: Double?
}
