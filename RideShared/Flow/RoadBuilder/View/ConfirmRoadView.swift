//
//  ConfirmRoadView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 03.01.2023.
//

import SwiftUI

struct ConfirmRoadView: View {
    
    @EnvironmentObject var roadBuilderModel: RoadBuilderViewModel
    @EnvironmentObject var searchLocationViewModel: SearchLocationViewModel
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            
            VStack(spacing: Paddings.padding0) {
                Text(Strings.ConfirmRoad.currentLocation)
                    .padding(Paddings.padding16)
                    .background {
                        Capsule()
                            .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                    }
                Rectangle()
                    .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                    .frame(width: 6, height: 50)
                if let location = searchLocationViewModel.location {
                    Text(location.title)
                        .padding(Paddings.padding16)
                        .background {
                            Capsule()
                                .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                        }
                }
            }
            .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            
            Text(roadBuilderModel.computePrice(forLocation: searchLocationViewModel.location).price)
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                .font(.system(size: 65, weight: .semibold))
            
            
            HStack {
                BigButton(title: Strings.Button.close) {
                    withAnimation {
                        roadBuilderModel.state = .clear
                    }
                }
                BigButton(title: Strings.Button.confirm.uppercased()) {
                    roadBuilderModel.confirmRoad(location: searchLocationViewModel.location, user: userManager.user)
                }
            }
            
        }
        .padding(Paddings.padding20)
        .disabled(roadBuilderModel.isLoadingInConfirmRoad)
        .overlay {
            if roadBuilderModel.isLoadingInConfirmRoad {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .background(Asset.Colors.backgroundColor.swiftUIColor.cornerRadius(20).ignoresSafeArea())
    }
    
}
