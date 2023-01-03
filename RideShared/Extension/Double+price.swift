//
//  Double+price.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 03.01.2023.
//

import Foundation

extension Double {
    
    var price: String {
        return "\(currencyFormatter.string(for: self) ?? "")₴"
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
}
