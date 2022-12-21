//
//  RideSharedApp.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI

@main
struct RideSharedApp: App {

    @State var user: User?

    var body: some Scene {
        WindowGroup {
            if let user {
                
                let binding = Binding {
                    return user
                } set: { value, _ in
                    self.user = value
                }
                
                if let _ = user.selectionParametrs {
                    TabView {
                        ProfileView(userManager: UserManager(user: user))
                            .tabItem {
                                Label(Strings.TabBar.profile, systemImage: "person.fill")
                            }
                    }
                } else {
                    QuestionnaireView(user: binding)
                }
                
            } else {
                AuthView(user: $user)
            }
        }
    }

}
