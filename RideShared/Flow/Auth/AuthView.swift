//
//  AuthView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI

struct AuthView: View {
    
    @Binding var user: User?
    let authManager: AuthManager
    
    @State var willShowingError = false
    @State var errorText = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text(Strings.General.title)
                .font(.title)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            Spacer()
            GoogleAuthButton(authManager: authManager) { result in
                switch result {
                case .success(let success):
                    user = success
                case .failure(let failure):
                    errorText = failure.localizedDescription
                    willShowingError = true
                }
            }
            .padding(.horizontal, Paddings.padding16)
        }
        .background(Color(Asset.Colors.backgroundColor.color).edgesIgnoringSafeArea(.all))
        .overlay(
            ErrorView(isShowing: $willShowingError, title: Strings.Error.SingIn.title, message: errorText)
                .transition(.opacity.animation(.default))
        )
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(user: .constant(User.preview), authManager: GoogleAuthManager())
    }
}
