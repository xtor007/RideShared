//
//  BigButton.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct BigButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(Color(Asset.Colors.textColor.color))
                Spacer()
            }
            .padding(.vertical, Paddings.padding20)
            .padding(.horizontal, Paddings.padding16)
            .background(
                Capsule()
                    .fill(Color(Asset.Colors.elementBackgroundColor.color))
            )
        }
    }
    
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(title: "Button") {
            print("1")
        }.background(Color.blue)
    }
}
