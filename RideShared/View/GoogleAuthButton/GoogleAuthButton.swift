//
//  GoogleAuthButton.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI
import GoogleSignIn

struct GoogleAuthButton: View {
    
    let authManager: AuthManager
    let callback: (Result<User, Error>) -> Void
    
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
        }
        .padding(.horizontal, Paddings.padding16)
        .padding(.vertical, Paddings.padding10)
        .background(
            Capsule()
                .fill(Color(Asset.Colors.elementBackgroundColor.color))
        )
        .onTapGesture {
            authManager.singIn(rootViewController: getRootViewController()) { result in
                switch result {
                case .success(let success):
                    callback(.success(User.preview))
                case .failure(let failure):
                    callback(.failure(failure))
                }
            }
        }
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            //
          }
        }
    }
    
}

struct GoogleAuthButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthButton(authManager: GoogleAuthManager()) { _ in
            print(1)
        }
        .background(Color.blue)
    }
}
