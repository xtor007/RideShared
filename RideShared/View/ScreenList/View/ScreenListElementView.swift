//
//  ScreenListElementView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

struct ScreenListElementView: View {
    
    let element: any ScreenListElement
    
    var body: some View {
        NavigationLink {
            element.content
        } label: {
            HStack {
                Spacer()
                Text(element.title)
                    .font(.title3)
                    .foregroundColor(Color(Asset.Colors.textColor.color))
                    .padding(.vertical, Paddings.padding30)
                Spacer()
            }
            .background(
                Hexagon()
                    .fill(Color(Asset.Colors.elementBackgroundColor.color))
            )
        }
    }
    
}

struct ScreenListElementView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenListElementView(element: ProfileListElement.driver(userManager: UserManager(user: User.preview)))
    }
}
