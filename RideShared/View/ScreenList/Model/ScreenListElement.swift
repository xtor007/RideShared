//
//  ScreenListElement.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

protocol ScreenListElement {

    var title: String { get }
    var content: AnyView { get }

}
