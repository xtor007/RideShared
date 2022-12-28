//
//  ProfileListElement.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

enum ProfileListElement: ScreenListElement {
    
    var title: String {
        switch self {
        case .adresses:
            return Strings.ProfileList.adresses.uppercased()
        case .driver:
            return Strings.ProfileList.driverSettings.uppercased()
        case .prioritets:
            return Strings.ProfileList.priotitets.uppercased()
        }
    }
    
    var content: AnyView {
        switch self {
        case .adresses:
            return AnyView(Text("s"))
        case .driver:
            return AnyView(Text("s"))
        case .prioritets(let user, let showingError, let errorText):
            return AnyView(QuestionnaireView(user: user, willShowingError: showingError, errorText: errorText))
        }
    }
    
    case adresses
    case prioritets(user: Binding<User>, willShowingError: Binding<Bool>, errorText: Binding<String>)
    case driver
    
}
