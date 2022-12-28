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
            return ProcessInfo.processInfo.environment[EnviromentVariables.serverURL]! + "auth/signIn"
        case .updateUser:
            return ProcessInfo.processInfo.environment[EnviromentVariables.serverURL]! + "auth/updateUser"
        }
    }
    
    case singIn, updateUser
    
}
