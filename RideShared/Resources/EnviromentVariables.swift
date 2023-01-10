//
//  EnviromentVariables.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum EnviromentVariables {
    static let googleClientID = ProcessInfo.processInfo.environment["googleClientID"] ?? "1070319083094-rhfna9ibe6pgrun9ag7f90ogbcdmcm95.apps.googleusercontent.com"
    static let serverURL = ProcessInfo.processInfo.environment["serverURL"] ?? "https://7f44-95-135-190-201.eu.ngrok.io"
}
