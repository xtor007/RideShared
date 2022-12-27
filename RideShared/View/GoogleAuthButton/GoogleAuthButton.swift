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
    
    @State private var isLoading = false
    
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
            if isLoading {
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
            if !isLoading {
                authManager.singIn(rootViewController: getRootViewController()) { result in
                    withAnimation {
                        isLoading = true
                    }
                    switch result {
                    case .success(let success):
                        success.user.refreshTokensIfNeeded { user, error in
                            if let error {
                                finishLoading(result: .failure(error))
                                isLoading = false
                                return
                            }
                            DispatchQueue.global(qos: .background).async {
                                NetworkManager.shared.auth(token: user!.idToken!.tokenString) { result in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success(let success):
                                            finishLoading(result: .success(success))
                                        case .failure(let failure):
                                            finishLoading(result: .failure(failure))
                                        }
                                    }
                                }
                            }
                        }
                    case .failure(let failure):
                        finishLoading(result: .failure(failure))
                    }
                }
            }
        }
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            //
          }
        }
    }
    
    private func finishLoading(result: Result<User, Error>) {
        isLoading = false
        callback(result)
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
