//
//  TripView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 08.01.2023.
//

import SwiftUI

struct TripView: View {

    let date: Date
    let price: Double
    let start: String
    let finish: String

    var body: some View {
        VStack(spacing: Paddings.padding8) {
            HStack {
                Text(date.stringFormat)
                Spacer()
                Text(price.price)
            }
            HStack {
                Text(start)
                Spacer()
                Text("->")
                Spacer()
                Text(finish)
            }
        }
        .foregroundColor(Asset.Colors.textColor.swiftUIColor)
    }

}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(date: .now, price: 43, start: "A", finish: "B")
    }
}
