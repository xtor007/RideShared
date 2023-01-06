//
//  ConfirmRoadView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 03.01.2023.
//

import SwiftUI

struct ConfirmRoadView: View {
    
    @EnvironmentObject var searchLocationModel: SearchLocationViewModel
    @EnvironmentObject var userManager: UserManager
    
    @Binding var state: RoadViewState
    
    @State var isLoading = false
    
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
                if let location = searchLocationModel.location {
                    Text(location.title)
                        .padding(Paddings.padding16)
                        .background {
                            Capsule()
                                .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                        }
                }
            }
            .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            
            Text(searchLocationModel.computePrice().price)
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                .font(.system(size: 65, weight: .semibold))
            
            
            HStack {
                BigButton(title: Strings.Button.close) {
                    withAnimation {
                        state = .clear
                    }
                }
                BigButton(title: Strings.Button.confirm.uppercased()) {
                    isLoading = true
                    DispatchQueue.global(qos: .background).async {
                        guard let startCoordinate = searchLocationModel.userLocation else {
                            return
                        }
                        guard let finishCoordinate = searchLocationModel.location?.coordinate else {
                            return
                        }
                        NetworkManager.shared.getDriver(
                            user: userManager.user,
                            way: SharedWay(
                                start: SharedLocation(
                                    latitude: startCoordinate.latitude,
                                    longitude: startCoordinate.longitude
                                ),
                                finish: SharedLocation(
                                    latitude: finishCoordinate.latitude,
                                    longitude: finishCoordinate.longitude
                                )
                            )
                        ) { result in
                            switch result {
                            case .success(let success):
                                print(success)
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                }
            }
            
        }
        .padding(Paddings.padding20)
        .disabled(isLoading)
        .overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .background(Asset.Colors.backgroundColor.swiftUIColor.cornerRadius(20).ignoresSafeArea())
    }
    
}
