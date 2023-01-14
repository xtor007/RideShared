//
//  HistoryViewModel.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 08.01.2023.
//

import SwiftUI

class HistroryViewModel: ObservableObject {

    @Published var trips = [Trip]()
    @Published var isLoading = false

    @Published var errorMessage = ""
    @Published var willShowError = false

    private let provider = HistoryProvider()

    func loadData(forUser user: User) {
        isLoading = true
        provider.loadTrips(forUser: user) { result in
            self.isLoading = false
            switch result {
            case .success(let success):
                self.trips = success.sorted(by: { trip1, trip2 in
                    return trip1.date.timeIntervalSince1970 > trip2.date.timeIntervalSince1970
                })
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                self.willShowError = true
            }
        }
    }

}
