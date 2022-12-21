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
        VStack {
            
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
                
            }
            
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userManager: UserManager(user: User()))
    }
}
