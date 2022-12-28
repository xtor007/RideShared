//
//  QuestionnaireView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var user: User
    
    @State var musicalPreferences = ""
    @State var genderIndex = 0
    @State var speedIndex = 0
    @State var carColorIndex = 0
    @State var leftAgeIndex = 18
    @State var rightAgeIndex = 99
    
    @State var priorities = Array(repeating: BlockImportance.notMatter, count: 5)
    
    @Binding var willShowingError: Bool
    @Binding var errorText: String
    
    @State var isLoading = false

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
                if musicalPreferences.isEmpty && priorities[0] != .notMatter {
                    errorText = Strings.Error.Questionnaire.musicField
                    withAnimation {
                        willShowingError = true
                    }
                } else {
                    user.selectionParametrs = SelectionParametrs(
                        musicalPreferences: priorities[0] == .notMatter ? nil : musicalPreferences,
                        musicalPrioritet: priorities[0].rawValue,
                        driverGenderIndex: priorities[1] == .notMatter ? nil : genderIndex,
                        genderPrioritet: priorities[1].rawValue,
                        driverMinAge: priorities[2] == .notMatter ? nil : leftAgeIndex,
                        driverMaxAge: priorities[2] == .notMatter ? nil : rightAgeIndex,
                        agePrioritet: priorities[2].rawValue,
                        speedIndex: priorities[3] == .notMatter ? nil : speedIndex,
                        speedPrioritet: priorities[3].rawValue,
                        carColorIndex: priorities[4] == .notMatter ? nil : carColorIndex,
                        colorPrioritet: priorities[4].rawValue
                    )
                    isLoading = true
                    presentationMode.wrappedValue.dismiss()
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
        .disabled(isLoading)
        .overlay(
            ErrorView(isShowing: $willShowingError, title: Strings.Error.Questionnaire.title, message: errorText)
                .transition(.opacity.animation(.default))
        )
        .overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onChange(of: willShowingError) { newValue in
            isLoading = false
        }
        
    }
    
    init(user: Binding<User>, willShowingError: Binding<Bool>, errorText: Binding<String>) {
        self._user = user
        self._willShowingError = willShowingError
        self._errorText = errorText
        if let priorities = user.wrappedValue.selectionParametrs {
            self._priorities = State(
                initialValue: priorities.getPriorities().compactMap({ value in
                    return BlockImportance(rawValue: value)
                })
            )
            if let musicalPregerences = priorities.musicalPreferences {
                self._musicalPreferences = State(initialValue: musicalPregerences)
            }
            if let genderIndex = priorities.driverGenderIndex {
                self._genderIndex = State(initialValue: genderIndex)
            }
            if let speedIndex = priorities.speedIndex {
                self._speedIndex = State(initialValue: speedIndex)
            }
            if let carColorIndex = priorities.carColorIndex {
                self._carColorIndex = State(initialValue: carColorIndex)
            }
            if let leftAgeIndex = priorities.driverMinAge {
                self._leftAgeIndex = State(initialValue: leftAgeIndex)
            }
            if let rightAgeIndex = priorities.driverMaxAge {
                self._rightAgeIndex = State(initialValue: rightAgeIndex)
            }
        }
    }

}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(user: .constant(User.preview), willShowingError: .constant(false), errorText: .constant(""))
    }
}
