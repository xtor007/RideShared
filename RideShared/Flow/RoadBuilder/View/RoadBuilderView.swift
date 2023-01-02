//
//  RoadBuilderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct RoadBuilderView: View {
    
    @State private var willShowingSearchView = false
    @State private var state: RoadViewState = .clear
    
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable(state: $state)
                .ignoresSafeArea()
            if state == .clear {
                SearchLocationField(willPresentSearch: $willShowingSearchView)
                    .padding(.top, Paddings.padding20)
                    .padding(.horizontal, Paddings.padding16)
            }
        }
        .fullScreenCover(isPresented: $willShowingSearchView) {
            SearchLocationView(isPresented: $willShowingSearchView, state: $state)
        }
    }

}

struct RoadBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        RoadBuilderView()
    }
}
