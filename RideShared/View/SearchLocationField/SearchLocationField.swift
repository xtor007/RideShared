//
//  SearchLocationField.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 01.01.2023.
//

import SwiftUI

struct SearchLocationField: View {

    @Binding var willPresentSearch: Bool

    var body: some View {
        HStack {
            Text(Strings.SearchLocation.where)
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            Spacer()
        }
        .padding(.horizontal, Paddings.padding16)
        .padding(.vertical, Paddings.padding10)
        .background {
            Capsule()
                .fill(Asset.Colors.elementBackgroundColor.swiftUIColor)
        }
        .onTapGesture {
            willPresentSearch = true
        }
    }

}

struct SearchLocationField_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationField(willPresentSearch: .constant(false))
    }
}
