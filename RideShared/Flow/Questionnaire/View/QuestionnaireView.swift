//
//  QuestionnaireView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    
    var appState: Binding<AppState>? = nil
    
    @State var musicalPreferences = ""
    @State var genderIndex = 0
    @State var speedIndex = 0
    @State var carColorIndex = 0
    @State var leftAgeIndex = 18
    @State var rightAgeIndex = 99
    
    @State var priorities = Array(repeating: BlockImportance.notMatter, count: 5)
    
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
                save()
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
            ErrorView(isShowing: $userManager.willShowError, title: Strings.Error.Questionnaire.title, message: userManager.errorMessage)
                .transition(.opacity.animation(.default))
        )
        .overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onChange(of: userManager.willShowError) { newValue in
            isLoading = false
        }
        .onAppear {
            setPrioritets()
        }
        
    }
    
    private func setPrioritets() {
        if let priorities = userManager.user.selectionParametrs {
            self.priorities = priorities.getPriorities().compactMap({ value in
                return BlockImportance(rawValue: value)
            })
            if let musicalPregerences = priorities.musicalPreferences {
                self.musicalPreferences = musicalPregerences
            }
            if let genderIndex = priorities.driverGenderIndex {
                self.genderIndex = genderIndex
            }
            if let speedIndex = priorities.speedIndex {
                self.speedIndex = speedIndex
            }
            if let carColorIndex = priorities.carColorIndex {
                self.carColorIndex = carColorIndex
            }
            if let leftAgeIndex = priorities.driverMinAge {
                self.leftAgeIndex = leftAgeIndex
            }
            if let rightAgeIndex = priorities.driverMaxAge {
                self.rightAgeIndex = rightAgeIndex
            }
        }
    }
    
    private func save() {
        if musicalPreferences.isEmpty && priorities[0] != .notMatter {
            userManager.errorMessage = Strings.Error.Questionnaire.musicField
            withAnimation {
                userManager.willShowError = true
            }
        } else {
            userManager.user.selectionParametrs = SelectionParametrs(
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
            if let appState {
                appState.wrappedValue = .main(manager: userManager)
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(appState: .constant(.questionnaire(manager: UserManager(user: User.preview))))
            .environmentObject(UserManager(user: User.preview))
    }
}
