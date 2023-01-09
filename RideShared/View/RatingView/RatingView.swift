//
//  RatingView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 09.01.2023.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Double

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { starIndex in
                Spacer()
                Image(systemName: Double(starIndex) > rating ? "star" : "star.fill")
                    .onTapGesture {
                        withAnimation {
                            rating = Double(starIndex)
                        }
                    }
            }
        }
    }

}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
