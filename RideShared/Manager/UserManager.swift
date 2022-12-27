//
//  UserManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

class UserManager: ObservableObject {
    
    @Published private(set) var user: User {
        didSet {
            DispatchQueue.global(qos: .background).async {
                NetworkManager.shared.updateUser(user: self.user) { result in
                    DispatchQueue.main.async {
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
        }
    }
    @Published private(set) var avatar: UIImage
    @Published private(set) var willShowError = false
    @Published private(set) var errorMessage = ""
    
    init(user: User) {
        self.user = user
        avatar = Asset.Images.defaultAvatar.image
        if let avatarLink = user.avatar {
            DispatchQueue.global(qos: .background).async {
                NetworkManager.shared.loadImage(link: avatarLink) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            self.avatar = success
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
    }
    
}
