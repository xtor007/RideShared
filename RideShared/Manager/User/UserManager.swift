//
//  UserManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

class UserManager: ObservableObject {

    private let provider = UserProvider()

    @Published var user: User {
        didSet {
            provider.updateUser(newValue: self.user) { result in
                switch result {
                case .success:
                    return
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.willShowError = true
                }
            }
        }
    }
    @Published private(set) var avatar: UIImage
    @Published var willShowError = false
    @Published var errorMessage = ""

    init(user: User) {
        self.user = user
        avatar = Asset.Images.defaultAvatar.image
        if let avatarLink = user.avatar {
            provider.loadAvatar(link: avatarLink) { result in
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
