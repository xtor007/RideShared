//
//  ServerPath.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum ServerPath {
    
    var path: String {
        switch self {
        case .singIn:
            return "auth/singIn"
        }
    }
    
    case singIn
    
}
