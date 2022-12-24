//
//  AuthManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation
import GoogleSignIn

protocol AuthManager {
    func singIn(rootViewController: UIViewController, _ handler: @escaping (Result<GIDSignInResult, Error>) -> Void)
}
