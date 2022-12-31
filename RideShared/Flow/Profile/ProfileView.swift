//
//  ProfileView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var userManager: UserManager

    var body: some View {
        VStack(alignment: .leading, spacing: Paddings.padding20) {
            
            HStack(spacing: Paddings.padding16) {
                
                Image(uiImage: userManager.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: Paddings.padding10) {
                    Text(userManager.user.name)
                        .font(.title)
                        .lineLimit(1...2)
                    Text("⭐️\(userManager.user.rating.rating)")
                        .font(.bold(.subheadline)())
                }
                .foregroundColor(Color(Asset.Colors.textColor.color))
                
            }
            .padding(.horizontal, Paddings.padding30)
            .padding(.top, Paddings.padding30)
            
            ScreenListView(data: [
                ProfileListElement.prioritets(
                    user: $userManager.user,
                    willShowingError: $userManager.willShowError,
                    errorText: $userManager.errorMessage
                ),
                ProfileListElement.adresses,
                ProfileListElement.driver(userManager: userManager)
            ])
            .padding(.horizontal, Paddings.padding20)
            
            Spacer()
            
        }
        .overlay(
            ErrorView(isShowing: $userManager.willShowError, title: Strings.Error.Error.title, message: userManager.errorMessage)
                .transition(.opacity.animation(.default))
        )
        .background(Color(Asset.Colors.backgroundColor.color).ignoresSafeArea())
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userManager: UserManager(user: User.preview))
    }
}
