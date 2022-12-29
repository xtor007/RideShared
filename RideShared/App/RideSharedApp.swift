//
//  RideSharedApp.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI
import GoogleSignIn

@main
struct RideSharedApp: App {

    @State var user: User?
    @State var isError = false
    @State var errorText = ""

    var body: some Scene {
        WindowGroup {
            if let user {
                
                let binding = Binding {
                    return user
                } set: { value, _ in
                    DispatchQueue.global(qos: .background).async {
                        NetworkManager.shared.updateUser(user: value) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success:
                                    self.user = value
                                case .failure(let failure):
                                    errorText = failure.localizedDescription
                                    isError = true
                                }
                            }
                        }
                    }
                }
                
                if let _ = user.selectionParametrs {
                    let userManager = UserManager(user: user)
                    NavigationView {
                        TabView {
                            ProfileView(userManager: userManager)
                                .tabItem {
                                    Label(Strings.TabBar.profile, systemImage: "person.fill")
                                }
                        }
                    }
                    .preferredColorScheme(.light)
                } else {
                    QuestionnaireView(user: binding, willShowingError: $isError, errorText: $errorText)
                        .preferredColorScheme(.light)
                }
                
            } else {
                AuthView(user: $user, authManager: GoogleAuthManager())
                    .preferredColorScheme(.light)
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
            }
        }
    }

}
