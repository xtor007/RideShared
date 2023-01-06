//
//  RoadBuilderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct RoadBuilderView: View {
    
    @EnvironmentObject var searchLocationModel: SearchLocationViewModel
    
    @State private var willShowingSearchView = false
    @State private var state: RoadViewState = .clear
    
    let provider = UserSideTripProvider()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable(state: $state)
                    .ignoresSafeArea()
                if state == .clear {
                    SearchLocationField(willPresentSearch: $willShowingSearchView)
                        .padding(.top, Paddings.padding20)
                        .padding(.horizontal, Paddings.padding16)
                }
            }
            if state == .buildRoad {
                ConfirmRoadView(provider: provider, state: $state)
                    .transition(.move(edge: .bottom))
            }
        }
        .fullScreenCover(isPresented: $willShowingSearchView) {
            SearchLocationView(isPresented: $willShowingSearchView, state: $state)
        }
        .onChange(of: state) { newValue in
            if newValue == .clear {
                searchLocationModel.location = nil
            }
        }
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                searchLocationModel.userLocation = location
            }
        }
    }

}

struct RoadBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        RoadBuilderView()
    }
}
