//
//  NetworkError.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case failedURL(message: String = "Failed URL")
    case failedData(message: String = "Failed data")
    case serverError(message: String = "Server error")
    case decodeImageError(message: String = "Decode image error")
    case codeFailed(message: String = "Code failed")
}
