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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DriverMapViewRepresentable(state: $driverWorkModel.state)
                .ignoresSafeArea()
            if driverWorkModel.state == .notWorking {
                BigButton(title: Strings.Button.start.uppercased()) {
                    driverWorkModel.searchClient(user: userManager.user)
                }
                .padding(.horizontal, Paddings.padding16)
                .padding(.bottom, Paddings.padding10)
            }
            if driverWorkModel.state == .searching {
                BigButton(title: Strings.Button.cancel) {
                    driverWorkModel.state = .notWorking
                    driverWorkModel.provider.cancelSearching()
                }
                .padding(.horizontal, Paddings.padding16)
                .padding(.bottom, Paddings.padding10)
            }
            if driverWorkModel.state == .confirmClient {
                VStack {
                    Spacer()
                    ConfirmingUserView(user: driverWorkModel.client!) { isConfirmed in
                        driverWorkModel.confirmUser(isConfirmed: isConfirmed, forUser: userManager.user)
                    }
                    Spacer()
                }
                .padding(.horizontal, Paddings.padding16)
            }
        }
        .overlay(
            ErrorView(isShowing: $driverWorkModel.willShowError, title: Strings.Error.Error.title, message: driverWorkModel.errorMessage)
                .transition(.opacity.animation(.default))
        )
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                driverWorkModel.userLocation = location
            }
        }
    }
    
}

struct DriverWorkView_Previews: PreviewProvider {
    static var previews: some View {
        DriverWorkView()
    }
}
