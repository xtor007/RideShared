//
//  ServerPath.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum ServerPath {
    
    var path: String {
        let path = EnviromentVariables.serverURL
        switch self {
        case .singIn:
            return path + "/auth/signIn"
        case .updateUser:
            return path + "/auth/updateUser"
        case .driverConfirmed:
            return path + "/driver/driverConfirmed"
        case .getDriver:
            return path + "/trip/getDriver"
        case .getClient:
            return path + "/trip/getClient"
        case.getAllTrips:
            return path + "/history/getAllTrips"
        }
    }
    
    case singIn, updateUser, driverConfirmed, getDriver, getClient, getAllTrips
    
}
