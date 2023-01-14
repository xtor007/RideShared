//
//  AuthViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import SwiftUI

class AuthViewModel: ObservableObject {

    let authManager: AuthManager
    let provider = AuthProvider()

    @Binding var appState: AppState
    @Published var willShowingError = false
    @Published var errorText = ""
    @Published var isLoading = false

    init(authManager: AuthManager, appState: Binding<AppState>) {
        self.authManager = authManager
        self._appState = appState
    }

    func buttonTapAction(rootViewController: UIViewController) {
        if !isLoading {
            withAnimation {
                self.isLoading = true
            }
            provider.signIn(manager: authManager, rootViewController: rootViewController) { result in
                self.finishLoading(result: result)
            }
        }
    }

    private func finishLoading(result: Result<User, Error>) {
        DispatchQueue.main.async {
            self.isLoading = false
            switch result {
            case .success(let success):
                let userManager = UserManager(user: success)
                self.appState = success.selectionParametrs == nil
                ? .questionnaire(manager: userManager)
                : .main(manager: userManager)
            case .failure(let failure):
                self.errorText = failure.localizedDescription
                self.willShowingError = true
            }
        }
    }

}
