//
//  HistoryView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 08.01.2023.
//

import SwiftUI

struct HistoryView: View {

    @EnvironmentObject var userManager: UserManager

    @ObservedObject var model: HistroryViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Paddings.padding10) {
                ForEach(model.trips, id: \.self) { trip in
                    if let start = trip.start,
                       let finish = trip.finish,
                       let date = trip.date,
                       let price = trip.price {
                        VStack {
                            TripView(date: date, price: price, start: start, finish: finish)
                            Divider()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(Paddings.padding16)
        .overlay(
            ErrorView(
                isShowing: $userManager.willShowError,
                title: Strings.Error.Questionnaire.title,
                message: userManager.errorMessage
            )
                .transition(.opacity.animation(.default))
        )
        .overlay(
            ErrorView(
                isShowing: $model.willShowError,
                title: Strings.Error.Questionnaire.title,
                message: model.errorMessage
            )
                .transition(.opacity.animation(.default))
        )
        .overlay {
            if model.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .background(Asset.Colors.backgroundColor.swiftUIColor.ignoresSafeArea())
        .onAppear {
            model.loadData(forUser: userManager.user)
        }
    }

}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(model: HistroryViewModel())
            .environmentObject(UserManager(user: User.preview))
    }
}
