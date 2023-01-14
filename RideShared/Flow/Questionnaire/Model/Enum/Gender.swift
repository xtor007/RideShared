//
//  Gender.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import Foundation

enum Gender: Int, CaseIterable {

    var title: String {
        switch self {
        case .male:
            return Strings.GenderBlock.male
        case .female:
            return Strings.GenderBlock.female
        }
    }

    case male = 0
    case female = 1

}
