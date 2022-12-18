//
//  Speed.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import Foundation

enum Speed: Int, CaseIterable {
    
    var title: String {
        switch self {
        case .slow:
            return Strings.SpeedBlock.slow
        case .medium:
            return Strings.SpeedBlock.medium
        case .fast:
            return Strings.SpeedBlock.fast
        }
    }
    
    case slow = 0
    case medium = 1
    case fast = 2
    
}
