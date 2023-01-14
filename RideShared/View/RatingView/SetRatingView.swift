//
//  SetRatingView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 10.01.2023.
//

import SwiftUI

struct SetRatingView: View {

    @Binding var rating: Double
    var musicRating: Binding<Double>?
    var speedRating: Binding<Double>?
    let callback: () -> Void

    var body: some View {
        VStack(spacing: Paddings.padding20) {
            Text(Strings.Rating.rate)
                .font(.title2)
            HStack {
                Text(Strings.Rating.rating)
                RatingView(rating: $rating)
            }
            .frame(width: UIScreen.main.bounds.width / 2)
            if let musicRating {
                HStack {
                    Text(Strings.Rating.music)
                    RatingView(rating: musicRating)
                }
                .frame(width: UIScreen.main.bounds.width / 2)
            }
            if let speedRating {
                HStack {
                    Text(Strings.Rating.speed)
                    RatingView(rating: speedRating)
                }
                .frame(width: UIScreen.main.bounds.width / 2)
            }
            BigButton(title: Strings.Button.finish, action: callback)
        }
        .foregroundColor(Asset.Colors.textColor.swiftUIColor)
        .padding(Paddings.padding30)
        .background(
            Asset.Colors.backgroundColor.swiftUIColor
                .cornerRadius(20)
        )
    }

}

struct SetRatingView_Previews: PreviewProvider {
    static var previews: some View {
        SetRatingView(rating: .constant(4), musicRating: .constant(3), speedRating: .constant(5)) {
            print(1)
        }
    }
}
