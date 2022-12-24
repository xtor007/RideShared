//
//  NetworkError.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case failedURL(message: String = "Failed URL")
}
