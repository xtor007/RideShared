//
//  AuthView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI

struct AuthView: View {
    
    @Binding var user: User?
    
    var body: some View {
        VStack {
            Spacer()
            Text(Strings.General.title)
                .font(.title)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            Spacer()
            GoogleAuthButton { user in
                self.user = user
            }
            .padding(.horizontal, Paddings.padding16)
        }
        .background(Color(Asset.Colors.backgroundColor.color).edgesIgnoringSafeArea(.all))
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(user: .constant(User.preview))
    }
}
