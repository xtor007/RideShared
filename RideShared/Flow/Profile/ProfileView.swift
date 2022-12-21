//
//  ProfileView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(spacing: Paddings.padding20) {
                
                HStack {
                    
                    Image(
                        uiImage: userManager.user.avatar.map({ data in
                            return UIImage(data: data)
                            ?? Asset.Images.defaultAvatar.image
                        })
                           ?? Asset.Images.defaultAvatar.image
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(Circle())
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: Paddings.padding10) {
                        Text(userManager.user.name)
                            .font(.title)
                            .lineLimit(1...2)
                        Text("⭐️\(userManager.user.rating.rating)")
                            .font(.bold(.subheadline)())
                    }
                    .foregroundColor(Color(Asset.Colors.textColor.color))
                    
                }
                .padding(.horizontal, Paddings.padding30)
                .padding(.top, Paddings.padding30)
                
                ScreenListView(data: [
                    ProfileListElement.prioritets,
                    ProfileListElement.adresses,
                    ProfileListElement.driver
                ])
                .padding(.horizontal, Paddings.padding20)
                
                Spacer()
                
            }
            .background(Color(Asset.Colors.backgroundColor.color).ignoresSafeArea())
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userManager: UserManager(user: User.preview))
    }
}
