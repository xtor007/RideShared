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
    
    @StateObject var searchLocationModel = SearchLocationViewModel()
    @StateObject var drivarLocationModel = SearchLocationViewModel()

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
                            RoadBuilderView()
                                .environmentObject(searchLocationModel)
                                .tabItem {
                                    Label(Strings.TabBar.road, systemImage: "map.fill")
                                }
                            ProfileView(userManager: userManager)
                                .tabItem {
                                    Label(Strings.TabBar.profile, systemImage: "person.fill")
                                }
                            if let taxiData = user.taxiData, taxiData.isConfirmed {
                                DriverWorkView()
                                    .environmentObject(drivarLocationModel)
                                    .tabItem {
                                        Label(Strings.TabBar.work, systemImage: "car.front.waves.up.fill")
                                    }
                            }
                        }
                        .onAppear {
                            let appearance = UITabBarAppearance()
                            appearance.backgroundColor = Asset.Colors.accentColor.color
                            appearance.selectionIndicatorTintColor = Asset.Colors.accentColor.color
                            UITabBar.appearance().standardAppearance = appearance
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
