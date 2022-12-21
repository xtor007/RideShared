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
        case .prioritets:
            return AnyView(Text("s"))
        }
    }
    
    case adresses, prioritets, driver
    
}
