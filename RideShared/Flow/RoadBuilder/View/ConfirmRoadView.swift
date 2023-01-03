//
//  ConfirmRoadView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 03.01.2023.
//

import SwiftUI

struct ConfirmRoadView: View {
    
    @Binding var state: RoadViewState
    
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
                Text("Montana")
                    .padding(Paddings.padding16)
                    .background {
                        Capsule()
                            .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
                    }
            }
            .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            
            Text(412.35.price)
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                .font(.system(size: 80, weight: .semibold))
            
            
            HStack {
                BigButton(title: Strings.Button.close) {
                    withAnimation {
                        state = .clear
                    }
                }
                BigButton(title: Strings.Button.confirm.uppercased()) {
                    print("Confirm")
                }
            }
            
        }
        .padding(Paddings.padding20)
        .background(Asset.Colors.backgroundColor.swiftUIColor.cornerRadius(20).ignoresSafeArea())
    }
    
}

struct ConfirmRoadView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmRoadView(state: .constant(.buildRoad))
    }
}
