//
//  LocationCellView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct LocationCellView: View {
    
    let locationName: String
    let locationAdress: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: Paddings.padding4) {
                Divider()
                Text(locationName)
                    .font(.bold(.title2)())
                Text(locationAdress)
                    .font(.footnote)
            }
        }
    }
    
}

struct LocationCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocationCellView(locationName: "McDonald's", locationAdress: "Svobody 18")
    }
}
