//
//  AuthView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var model: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(Strings.General.title)
                .font(.title)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            Spacer()
            GoogleAuthButton()
            .padding(.horizontal, Paddings.padding16)
        }
        .background(Color(Asset.Colors.backgroundColor.color).edgesIgnoringSafeArea(.all))
        .overlay(
            ErrorView(isShowing: $model.willShowingError, title: Strings.Error.SingIn.title, message: model.errorText)
                .transition(.opacity.animation(.default))
        )
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel(authManager: GoogleAuthManager(), user: .constant(User.preview)))
    }
}
