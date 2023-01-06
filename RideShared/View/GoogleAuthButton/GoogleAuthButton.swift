//
//  GoogleAuthButton.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI
import GoogleSignIn

struct GoogleAuthButton: View {
    
    @EnvironmentObject var model: AuthViewModel
    
    var body: some View {
        HStack {
            Image(uiImage: Asset.Images.googleIcon.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .padding(.leading, Paddings.padding10)
            Spacer()
            Text(Strings.Google.singIn)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            Spacer()
            if model.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .padding(.horizontal, Paddings.padding16)
        .padding(.vertical, Paddings.padding10)
        .background(
            Capsule()
                .fill(Color(Asset.Colors.elementBackgroundColor.color))
        )
        .onTapGesture {
            model.buttonTapAction(rootViewController: getRootViewController())
        }
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { _, _ in}
        }
    }
    
}

struct GoogleAuthButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthButton()
            .environmentObject(AuthViewModel(authManager: GoogleAuthManager(), appState: .constant(.notAuthorized)))
            .background(Color.blue)
    }
}
