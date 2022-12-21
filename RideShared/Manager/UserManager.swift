//
//  UserManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import Foundation

class UserManager: ObservableObject {
    
    @Published private(set) var user: User
    
    init(user: User) {
        self.user = user
    }
    
}
