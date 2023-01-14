//
//  CarColor.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import Foundation

enum CarColor: Int, CaseIterable {

    var title: String {
        switch self {
        case .white:
            return Strings.CarColor.white
        case .light:
            return Strings.CarColor.light
        case .black:
            return Strings.CarColor.black
        }
    }

    case white = 0
    case light = 1
    case black = 2

}
