//
//  RoadBuilderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct RoadBuilderView: View {
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct RoadBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        RoadBuilderView()
    }
}
