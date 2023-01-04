//
//  DriverWorkView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import SwiftUI

struct DriverWorkView: View {
    var body: some View {
        ZStack {
            MapViewRepresentable(state: .constant(.clear))
        }
        .ignoresSafeArea()
    }
}

struct DriverWorkView_Previews: PreviewProvider {
    static var previews: some View {
        DriverWorkView()
    }
}
