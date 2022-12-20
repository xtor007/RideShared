//
//  ErrorView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 20.12.2022.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var isShowing: Bool
    let title: String
    let message: String
    
    private let size: CGFloat = 250
    
    var body: some View {
        ZStack {
            if isShowing {
                VStack(spacing: Paddings.padding20) {
                    Text(title)
                        .font(.title)
                        .foregroundColor(Color(Asset.Colors.elementBackgroundColor.color))
                        .padding(.top, Paddings.padding10)
                        .multilineTextAlignment(.center)
                    Text(message)
                        .foregroundColor(Color(Asset.Colors.backgroundColor.color))
                        .multilineTextAlignment(.center)
                    Spacer()
                    BigButton(title: Strings.Button.close) {
                        withAnimation {
                            isShowing = false
                        }
                    }
                    .padding(.bottom, Paddings.padding10)
                    .padding(.horizontal, Paddings.padding16)
                }
                .background(
                    Image(uiImage: Asset.Images.errorIcon.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                )
                .frame(width: size, height: size)
            }
        }
    }
    
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(isShowing: .constant(true), title: "Error", message: "Message")
            .background(Color.red)
    }
}
