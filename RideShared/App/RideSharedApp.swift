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

    @State var state = AppState.notAuthorized
    
    @StateObject var searchLocationModel = SearchLocationViewModel()
    @StateObject var driverLocationModel = DriverWorkViewModel()

    var body: some Scene {
        WindowGroup {
            switch state {
            case .notAuthorized:
                AuthView()
                    .environmentObject(AuthViewModel(authManager: GoogleAuthManager(), appState: $state))
                    .preferredColorScheme(.light)
                    .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
            case .questionnaire(let manager):
                QuestionnaireView(appState: $state)
                    .environmentObject(manager)
                    .preferredColorScheme(.light)
            case .main(let manager):
                NavigationView {
                    TabView {
                        RoadBuilderView()
                            .environmentObject(searchLocationModel)
                            .tabItem {
                                Label(Strings.TabBar.road, systemImage: "map.fill")
                            }
                        HistoryView(model: HistroryViewModel())
                            .tabItem {
                                Label(Strings.TabBar.history, systemImage: "clock.fill")
                            }
                        ProfileView(appState: $state)
                            .tabItem {
                                Label(Strings.TabBar.profile, systemImage: "person.fill")
                            }
                        if let taxiData = manager.user.taxiData, taxiData.isConfirmed {
                            DriverWorkView()
                                .environmentObject(driverLocationModel)
                                .tabItem {
                                    Label(Strings.TabBar.work, systemImage: "car.front.waves.up.fill")
                                }
                        }
                    }
                    .environmentObject(manager)
                    .onAppear {
                        let appearance = UITabBarAppearance()
                        appearance.backgroundColor = Asset.Colors.accentColor.color
                        appearance.selectionIndicatorTintColor = Asset.Colors.accentColor.color
                        UITabBar.appearance().standardAppearance = appearance
                    }
                }
                .preferredColorScheme(.light)
            }
        }
    }

}
