//
//  GoogleAuthButton.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 17.12.2022.
//

import SwiftUI

struct GoogleAuthButton: View {
    
    let callback: (User) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Image(uiImage: Asset.Images.googleIcon.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            Spacer()
            Text(Strings.Google.singIn)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            Spacer()
        }
        .padding(.horizontal, Paddings.padding16)
        .padding(.vertical, Paddings.padding10)
        .background(
            Capsule()
                .fill(Color(Asset.Colors.elementBackgroundColor.color))
        )
        .onTapGesture {
            callback(User()) //AUTH
        }
    }
    
}

struct GoogleAuthButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthButton { _ in 
            print(1)
        }
        .background(Color.blue)
    }
}
