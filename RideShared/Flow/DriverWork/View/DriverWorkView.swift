//
//  DriverWorkView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import SwiftUI

struct DriverWorkView: View {
    
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var driverWorkModel: DriverWorkViewModel
    
    @State var state = DriverWorkState.notWorking
    private let provider = DriverSideTripProvider()
    
    @State var willShowError = false
    @State var errorMessage = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DriverMapViewRepresentable(state: $state)
                .ignoresSafeArea()
            if state == .notWorking {
                BigButton(title: Strings.Button.start.uppercased()) {
                    searchClient()
                }
                .padding(.horizontal, Paddings.padding16)
                .padding(.bottom, Paddings.padding10)
            }
            if state == .searching {
                BigButton(title: Strings.Button.cancel) {
                    state = .notWorking
                    provider.cancelSearching()
                }
                .padding(.horizontal, Paddings.padding16)
                .padding(.bottom, Paddings.padding10)
            }
            if state == .confirmClient {
                VStack {
                    Spacer()
                    ConfirmingUserView(user: driverWorkModel.client!) { isConfirmed in
                        print(isConfirmed)
                    }
                    Spacer()
                }
            }
        }
        .overlay(
            ErrorView(isShowing: $willShowError, title: Strings.Error.Error.title, message: errorMessage)
                .transition(.opacity.animation(.default))
        )
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                driverWorkModel.userLocation = location
            }
        }
    }
    
    private func searchClient() {
        if let location = driverWorkModel.userLocation {
            state = .searching
            provider.getClient(
                user: userManager.user,
                location: SharedLocation(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            ) { result in
                switch result {
                case .success(let success):
                    driverWorkModel.client = success
                    state = .confirmClient
                case .failure(let failure):
                    errorMessage = failure.localizedDescription
                    willShowError = true
                    self.state = .notWorking
                }
            }
        }
    }
    
}

struct DriverWorkView_Previews: PreviewProvider {
    static var previews: some View {
        DriverWorkView()
    }
}
