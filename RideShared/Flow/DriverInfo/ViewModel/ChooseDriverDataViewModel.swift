//
//  DriverInfoViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import SwiftUI

class ChooseDriverDataViewModel: ObservableObject {

    @ObservedObject var userManager: UserManager

    let provider = ChooseDriverDataProvider()

    @Binding var isPresented: Bool

    @State var genderIndex = 0
    @State var dateOfBirth = Date(timeIntervalSince1970: 0)
    @State var yourCarColorIndex = 0

    init(isPresented: Binding<Bool>, manager: UserManager) {
        self._isPresented = isPresented
        self.userManager = manager
    }

    func saveData() {
        userManager.user.taxiData = TaxiData(
            isConfirmed: false,
            taxiTripCount: 0,
            musicRating: 5.0,
            genderIndex: genderIndex,
            dateOfBirth: dateOfBirth,
            speedRating: 5.0,
            yourCarColorIndex: yourCarColorIndex
        )
        withAnimation {
            isPresented = false
        }
        provider.saveDriverData(user: userManager.user) { result in
            switch result {
            case .success:
                return
            case .failure(let failure):
                self.userManager.user.taxiData = nil
                self.userManager.errorMessage = failure.localizedDescription
                self.userManager.willShowError = true
            }
        }
    }

}
