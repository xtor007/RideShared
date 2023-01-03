//
//  SearchLocationView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct SearchLocationView: View {
    
    @Binding var isPresented: Bool
    @Binding var state: RoadViewState
    
    @EnvironmentObject var model: SearchLocationViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    isPresented = false
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
                                    state = .buildRoad
                                    isPresented = false
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

struct SearchLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(isPresented: .constant(true), state: .constant(.clear))
    }
}
