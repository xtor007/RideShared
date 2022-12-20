//
//  BlockImportance.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import Foundation

enum BlockImportance: Int, CaseIterable {
    
    var title: String {
        switch self {
        case .notMatter:
            return Strings.Importance.notMatter
        case .low:
            return Strings.Importance.low
        case .medium:
            return Strings.Importance.medium
        case .hight:
            return Strings.Importance.hight
        }
    }
    
    case notMatter = 0
    case low = 1
    case medium = 2
    case hight = 3
    
}
