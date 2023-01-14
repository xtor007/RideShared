//
//  ConfirmingUserView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import SwiftUI

struct ConfirmingUserView: View {

    let user: User
    let callback: (Bool) -> Void

    @State private var avatar = Asset.Images.defaultAvatar.image

    var body: some View {
        VStack(spacing: Paddings.padding20) {

            HStack {

                Image(uiImage: avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(Circle())

                Spacer()

                VStack(alignment: .leading, spacing: Paddings.padding10) {
                    Text(user.name)
                        .font(.bold(.title)())
                        .lineLimit(1...2)
                    HStack {
                        Text("⭐️\(user.rating.rating)")
                        if let taxiData = user.taxiData {
                            Spacer()
                            Text("🎶\(taxiData.musicRating.rating)")
                            Spacer()
                            Text("⚡️\(taxiData.speedRating.rating)")
                        }
                    }
                    .padding(.horizontal, Paddings.padding16)
                    .padding(.vertical, Paddings.padding10)
                    .background(
                        Capsule()
                            .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                    )
                }
                .foregroundColor(Color(Asset.Colors.textColor.color))

            }

            HStack {
                BigButton(title: Strings.Button.close) {
                    callback(false)
                }
                BigButton(title: Strings.Button.confirm) {
                    callback(true)
                }
            }

        }
        .padding(.horizontal, Paddings.padding16)
        .onAppear {
            if let avatarLink = user.avatar {
                DispatchQueue.global(qos: .background).async {
                    NetworkManager.shared.loadImage(link: avatarLink) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let success):
                                self.avatar = success
                            case .failure:
                                break
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, Paddings.padding16)
        .background(Asset.Colors.backgroundColor.swiftUIColor.ignoresSafeArea())
        .cornerRadius(20)
    }

}

struct ConfirmingUserView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmingUserView(user: User.preview) { _ in
            print(1)
        }
    }
}
