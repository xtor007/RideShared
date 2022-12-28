//
//  ScreenView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

struct ScreenListView: View {
    
    let data: [any ScreenListElement]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Paddings.padding20) {
                ForEach(0..<data.count, id: \.self) { listElementIndex in
                    ScreenListElementView(element: data[listElementIndex])
                }
            }
        }
    }
    
}

struct ScreenListView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenListView(data: [ProfileListElement.driver, ProfileListElement.adresses])
    }
}
