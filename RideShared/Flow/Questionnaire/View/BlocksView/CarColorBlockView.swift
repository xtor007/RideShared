//
//  CarColorBlockView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct CarColorBlockView: View {

    @Binding var colorIndex: Int

    var body: some View {
        Picker("", selection: $colorIndex) {
            ForEach(0..<CarColor.allCases.count, id: \.self) { index in
                Text(CarColor(rawValue: index)!.title).tag(index)
            }
        }
        .pickerStyle(.segmented)
    }

}

struct CarColorBlockView_Previews: PreviewProvider {
    static var previews: some View {
        CarColorBlockView(colorIndex: .constant(0))
    }
}
