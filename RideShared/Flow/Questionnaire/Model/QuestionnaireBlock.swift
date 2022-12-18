//
//  QuestionnaireBlock.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

enum QuestionnaireBlock {
    
    var title: String {
        switch self {
        case .music:
            return Strings.Questionnaire.music
        case .driverGender:
            return Strings.Questionnaire.gender
        case .driverAge:
            return Strings.Questionnaire.age
        case .speed:
            return Strings.Questionnaire.speed
        case .carColor:
            return Strings.Questionnaire.color
        }
    }
    
    var content: AnyView {
        return AnyView(Text(self.title))
    }
    
    case music, driverGender, driverAge, speed, carColor
    
}
