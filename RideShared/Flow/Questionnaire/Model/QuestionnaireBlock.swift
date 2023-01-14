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
        case .driverAge(let leftIndex, let rightIndex):
            return AnyView(DoublePointSliderView(
                data: 18...99,
                leftIndex: leftIndex,
                rightIndex: rightIndex
            )
                .padding(.bottom, 50))
        case .speed(let speedIndex):
            return AnyView(SpeedBlockView(speedIndex: speedIndex))
        case .carColor(let colorIndex):
            return AnyView(CarColorBlockView(colorIndex: colorIndex))
        }
    }

    case music(Binding<String>), driverGender(Binding<Int>)
    case driverAge(left: Binding<Int>, right: Binding<Int>), speed(Binding<Int>), carColor(Binding<Int>)

}
