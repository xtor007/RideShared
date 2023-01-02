//
//  RoadBuilderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct RoadBuilderView: View {
    
    @State private var willShowingSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable()
                .ignoresSafeArea()
            SearchLocationField(willPresentSearch: $willShowingSearchView)
                .padding(.top, Paddings.padding20)
                .padding(.horizontal, Paddings.padding16)
        }
        .fullScreenCover(isPresented: $willShowingSearchView) {
            SearchLocationView(isPresented: $willShowingSearchView)
        }
    }

}

struct RoadBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        RoadBuilderView()
    }
}
