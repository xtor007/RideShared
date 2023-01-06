//
//  SharedPath.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import Foundation

struct SharedWay: Codable {
    let start: SharedLocation
    let finish: SharedLocation
}
