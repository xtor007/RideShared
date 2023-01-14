//
//  SearchLocationView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct SearchLocationView: View {

    let close: (Bool) -> Void

    @EnvironmentObject var model: SearchLocationViewModel

    var body: some View {
        VStack {

            HStack {
                Spacer()
                Button {
                    close(false)
                } label: {
                    Text(Strings.Button.close)
                        .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                }

            }

            TextField(Strings.SearchLocation.where, text: $model.locationName)
                .textFieldStyle(.roundedBorder)
                .frame(height: 50)

            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(model.locations, id: \.self) { location in
                        LocationCellView(locationName: location.title, locationAdress: location.subtitle)
                            .onTapGesture {
                                withAnimation {
                                    model.setLocation(location)
                                    close(true)
                                }
                            }
                    }
                }
            }

        }
        .padding(.horizontal, Paddings.padding16)
        .background(Asset.Colors.backgroundColor.swiftUIColor)
    }

}
