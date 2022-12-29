//
//  DriverInfoView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 28.12.2022.
//

import SwiftUI

struct DriverInfoView: View {
    
    @ObservedObject var userManager: UserManager
    
    @State var isShowingChooseData = false
    
    var body: some View {
        content()
            .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            .padding(.horizontal, Paddings.padding16)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.Colors.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all))
            .overlay(
                ErrorView(isShowing: $userManager.willShowError, title: Strings.Error.Error.title, message: userManager.errorMessage)
                    .transition(.opacity.animation(.default))
            )
            .fullScreenCover(isPresented: $isShowingChooseData) {
                ChooseDriverDataView(userManager: userManager, isPresented: $isShowingChooseData)
            }
    }
    
    @ViewBuilder
    private func content() -> some View {
        if let taxiData = userManager.user.taxiData {
            HStack {
                VStack(alignment: .leading, spacing: Paddings.padding20) {
                    HStack {
                        Circle()
                            .fill(taxiData.isConfirmed ? Asset.Colors.confirmed.swiftUIColor : Asset.Colors.notConfirmed.swiftUIColor)
                            .frame(width: 16, height: 16)
                        Text(taxiData.isConfirmed ? Strings.DriverInfo.Status.confirmed : Strings.DriverInfo.Status.notConfirmed)
                    }
                    Text(userManager.user.name)
                        .font(.title)
                    Text(taxiData.dateOfBirth.stringFormat)
                    HStack {
                        Text("⭐️\(userManager.user.rating.rating)")
                        Spacer()
                        Text("🎶\(taxiData.musicRating.rating)")
                        Spacer()
                        Text("⚡️\(taxiData.speedRating.rating)")
                    }
                    .padding(.horizontal, Paddings.padding16)
                    .padding(.vertical, Paddings.padding10)
                    .background(
                        Capsule()
                            .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                    )
                    Spacer()
                }
                .padding(.top, Paddings.padding16)
                Spacer()
            }
        } else {
            VStack {
                Text(Strings.DriverInfo.question)
                    .font(.title)
                BigButton(title: Strings.General.yes.uppercased()) {
                    isShowingChooseData = true
                }
            }
        }
    }

}

struct DriverInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DriverInfoView(userManager: UserManager(user: User.preview))
    }
}
