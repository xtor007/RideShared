//
//  QuestionnaireView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @Binding var user: User
    
    @State var musicalPreferences = ""
    @State var genderIndex = 0
    @State var speedIndex = 0
    @State var carColorIndex = 0
    @State var leftAgeIndex = 18
    @State var rightAgeIndex = 99
    
    @State var priorities = Array(repeating: BlockImportance.notMatter, count: 5)
    
    @State var willShowingError = false
    @State var errorText = ""

    var body: some View {
        
        let blocks: [QuestionnaireBlock] = [
            .music($musicalPreferences),
            .driverGender($genderIndex),
            .driverAge(left: $leftAgeIndex, right: $rightAgeIndex),
            .speed($speedIndex),
            .carColor($carColorIndex)
        ]
        
        VStack {
            Text(Strings.Questionnaire.title)
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            ScrollView(showsIndicators: false) {
                VStack(spacing: Paddings.padding16) {
                    ForEach(0..<blocks.count, id: \.self) { blockIndex in
                        QuestionnaireBlockView(
                            blockName: blocks[blockIndex].title.lowercased(),
                            contentView: blocks[blockIndex].content,
                            priority: $priorities[blockIndex]
                        )
                    }
                }
            }
            BigButton(title: Strings.Button.finish.uppercased()) {
                if musicalPreferences.isEmpty {
                    errorText = Strings.Error.Questionnaire.musicField
                    withAnimation {
                        willShowingError = true
                    }
                } else {
                    user.selectionParametrs = SelectionParametrs(
                        musicalPreferences: musicalPreferences,
                        musicalPrioritet: priorities[0].rawValue,
                        driverGenderIndex: genderIndex,
                        genderPrioritet: priorities[1].rawValue,
                        driverMinAge: leftAgeIndex,
                        driverMaxAge: rightAgeIndex,
                        agePrioritet: priorities[2].rawValue,
                        speedIndex: speedIndex,
                        speedPrioritet: priorities[3].rawValue,
                        carColorIndex: carColorIndex,
                        colorPrioritet: priorities[4].rawValue
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Paddings.padding24)
        .padding(.top, Paddings.padding20)
        .background(
            Color(Asset.Colors.backgroundColor.color).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        .overlay(
            ErrorView(isShowing: $willShowingError, title: Strings.Error.Questionnaire.title, message: errorText)
                .transition(.opacity.animation(.default))
        )
        
    }

}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(user: .constant(User()))
    }
}
