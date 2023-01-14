//
//  EnviromentVariables.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum EnviromentVariables {
    static let googleClientID = ProcessInfo.processInfo.environment["googleClientID"]
    static let serverURL = ProcessInfo.processInfo.environment["serverURL"]
}
