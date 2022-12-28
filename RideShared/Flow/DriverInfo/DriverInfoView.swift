//
//  DriverInfoView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 28.12.2022.
//

import SwiftUI

struct DriverInfoView: View {
    
    let userManager: UserManager
    
    var body: some View {
        content()
            .padding(.horizontal, Paddings.padding16)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.Colors.backgroundColor.swiftUIColor.edgesIgnoringSafeArea(.all))
    }
    
    @ViewBuilder
    private func content() -> some View {
        if let taxiData = userManager.user.taxiData {
            Text("ok")
        } else {
            VStack {
                Text(Strings.DriverInfo.question)
                    .font(.title)
                    .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                BigButton(title: Strings.General.yes.uppercased()) {
                    print(1)
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
