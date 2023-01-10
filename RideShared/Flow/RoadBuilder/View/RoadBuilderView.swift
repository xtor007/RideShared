//
//  RoadBuilderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct RoadBuilderView: View {
    
    @EnvironmentObject var model: RoadBuilderViewModel
    @EnvironmentObject var searchLocationViewModel: SearchLocationViewModel
    
    let provider = UserSideTripProvider()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable()
                    .ignoresSafeArea()
                if model.state == .clear {
                    SearchLocationField(willPresentSearch: $model.willShowingSearchView)
                        .padding(.top, Paddings.padding20)
                        .padding(.horizontal, Paddings.padding16)
                }
            }
            if model.state == .buildRoad {
                ConfirmRoadView()
                    .transition(.move(edge: .bottom))
            }
            if model.state == .confirmDriver {
                VStack {
                    Spacer()
                    ConfirmingUserView(user: model.driver!) { isConfirmed in
                        model.confirmDriver(isConfirmed: isConfirmed)
                    }
                    Spacer()
                }
                .padding(.horizontal, Paddings.padding16)
            }
        }
        .fullScreenCover(isPresented: $model.willShowingSearchView) {
            SearchLocationView() { isFinished in
                model.willShowingSearchView = false
                model.state = isFinished ? .buildRoad : .clear
            }
        }
        .onChange(of: model.state) { newValue in
            if newValue == .clear {
                searchLocationViewModel.location = nil
            }
        }
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location {
                model.userLocation = location
            }
        }
    }

}

struct RoadBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        RoadBuilderView()
    }
}
