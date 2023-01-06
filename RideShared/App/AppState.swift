//
//  AppState.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 06.01.2023.
//

import Foundation

enum AppState {
    case notAuthorized, questionnaire(manager: UserManager), main(manager: UserManager)
}
