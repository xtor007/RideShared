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
        switch self {
        case .music(let musicalPreferences):
            return AnyView(MusicBlockView(musicalPreferences: musicalPreferences))
        case .driverGender(let genderIndex):
            return AnyView(GenderBlockView(genderIndex: genderIndex))
        case .driverAge:
            return AnyView(Text(self.title))
        case .speed:
            return AnyView(Text(self.title))
        case .carColor:
            return AnyView(Text(self.title))
        }
    }
    
    case music(Binding<String>), driverGender(Binding<Int>), driverAge, speed, carColor
    
}
