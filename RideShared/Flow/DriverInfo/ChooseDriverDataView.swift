//
//  ChooseDriverDataView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 28.12.2022.
//

import SwiftUI

struct ChooseDriverDataView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let userManager: UserManager
    
    @State private var genderIndex = 0
    @State private var dateOfBirth = Date(timeIntervalSince1970: 0)
    @State private var yourCarColorIndex = 0
    
    var body: some View {
        VStack(spacing: Paddings.padding30) {
            
            Text(Strings.DriverInfo.questionnaire)
                .font(.title)
            
            HStack {
                Text(Strings.DriverInfo.gender)
                Spacer()
            }
            
            GenderBlockView(genderIndex: $genderIndex)
            
            DatePicker(Strings.DriverInfo.dateOfBirth, selection: $dateOfBirth, displayedComponents: [.date])
            
            HStack {
                Text(Strings.DriverInfo.carColor)
                Spacer()
            }
            
            CarColorBlockView(colorIndex: $yourCarColorIndex)
            
            Spacer()
            
            BigButton(title: Strings.Button.finish.uppercased()) {
                userManager.user.taxiData = TaxiData(
                    taxiTripCount: 0,
                    musicRating: 5.0,
                    genderIndex: genderIndex,
                    dateOfBirth: dateOfBirth,
                    speedRating: 5.0,
                    yourCarColorIndex: yourCarColorIndex
                )
                presentationMode.wrappedValue.dismiss()
            }
            
        }
        .foregroundColor(Asset.Colors.textColor.swiftUIColor)
        .padding(.top, Paddings.padding16)
        .padding(.horizontal, Paddings.padding16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.Colors.backgroundColor.swiftUIColor.ignoresSafeArea())
    }
    
}

struct ChooseDriverDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDriverDataView(userManager: UserManager(user: User.preview))
    }
}
