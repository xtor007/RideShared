//
//  GenderBlockView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct GenderBlockView: View {
    
    @Binding var genderIndex: Int
    
    var body: some View {
        Picker("", selection: $genderIndex) {
            ForEach(0..<Gender.allCases.count, id: \.self) { index in
                Text(Gender(rawValue: index)!.title).tag(index)
            }
        }
        .pickerStyle(.segmented)
    }
    
}

struct GenderBlockView_Previews: PreviewProvider {
    static var previews: some View {
        GenderBlockView(genderIndex: .constant(0))
    }
}
