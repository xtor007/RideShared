//
//  GoogleAuthManager.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 24.12.2022.
//

import Foundation
import GoogleSignIn

class GoogleAuthManager: AuthManager {
    
    func singIn(rootViewController: UIViewController, _ handler: @escaping (Result<GIDSignInResult, Error>) -> Void) {
        let clientID = EnviromentVariables.googleClientID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            guard let result = signInResult else {
                handler(.failure(error!))
                return
            }
            handler(.success(result))
        }
    }
    
}
