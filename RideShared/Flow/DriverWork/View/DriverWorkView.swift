//
//  DriverWorkView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 04.01.2023.
//

import SwiftUI

struct DriverWorkView: View {
    
    @State var state = DriverWorkState.notWorking
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DriverMapViewRepresentable(state: $state)
                .ignoresSafeArea()
            if state == .notWorking {
                BigButton(title: Strings.Button.start.uppercased()) {
                    state = .searching
                }
                .padding(.bottom, Paddings.padding10)
            }
        }
    }
    
}

struct DriverWorkView_Previews: PreviewProvider {
    static var previews: some View {
        DriverWorkView()
    }
}
