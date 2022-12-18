//
//  SpeedBlockView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct SpeedBlockView: View {
    
    @Binding var speedIndex: Int
    
    var body: some View {
        Picker("", selection: $speedIndex) {
            ForEach(0..<Speed.allCases.count, id: \.self) { index in
                Text(Speed(rawValue: index)!.title).tag(index)
            }
        }
        .pickerStyle(.segmented)
    }
    
}

struct SpeedBlockView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedBlockView(speedIndex: .constant(0))
    }
}
