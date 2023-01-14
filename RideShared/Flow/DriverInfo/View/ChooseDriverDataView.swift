//
//  ChooseDriverDataView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 28.12.2022.
//

import SwiftUI

struct ChooseDriverDataView: View {

    @EnvironmentObject var userManager: UserManager

    @ObservedObject var model: ChooseDriverDataViewModel

    var body: some View {
        VStack(spacing: Paddings.padding30) {

            Text(Strings.DriverInfo.questionnaire)
                .font(.title)

            HStack {
                Text(Strings.DriverInfo.gender)
                Spacer()
            }

            GenderBlockView(genderIndex: $model.genderIndex)

            DatePicker(Strings.DriverInfo.dateOfBirth, selection: $model.dateOfBirth, displayedComponents: [.date])

            HStack {
                Text(Strings.DriverInfo.carColor)
                Spacer()
            }

            CarColorBlockView(colorIndex: $model.yourCarColorIndex)

            Spacer()

            HStack {

                BigButton(title: Strings.Button.close) {
                    withAnimation {
                        model.isPresented = false
                    }
                }

                BigButton(title: Strings.Button.finish.uppercased()) {
                    model.saveData()
                }

            }

        }
        .overlay(
            ErrorView(
                isShowing: $userManager.willShowError,
                title: Strings.Error.Error.title,
                message: userManager.errorMessage
            )
                .transition(.opacity.animation(.default))
        )
        .foregroundColor(Asset.Colors.textColor.swiftUIColor)
        .padding(.top, Paddings.padding16)
        .padding(.horizontal, Paddings.padding16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.Colors.backgroundColor.swiftUIColor.ignoresSafeArea())
    }

}

struct ChooseDriverDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDriverDataView(
            model: ChooseDriverDataViewModel(isPresented: .constant(true), manager: UserManager(user: User.preview))
        )
            .environmentObject(UserManager(user: User.preview))
    }
}
