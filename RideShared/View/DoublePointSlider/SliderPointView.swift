//
//  SliderPointView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct SliderPointView: View {

    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: Paddings.padding0) {

            VStack(spacing: DoubleSliderConstants.triangleTopDistande) {
                Circle()
                    .stroke(Color(Asset.Colors.borderColor.color), lineWidth: DoubleSliderConstants.pointBorderWidth)
                    .background(Color(Asset.Colors.elementBackgroundColor.color))
                    .frame(width: DoubleSliderConstants.pointSize, height: DoubleSliderConstants.pointSize)

                Triangle()
                    .fill(Color.black)
                    .frame(width: DoubleSliderConstants.triangleSize, height: DoubleSliderConstants.triangleSize)
            }
            .padding(.leading, DoubleSliderConstants.triangleSideDistance)

            Text(text)
                .foregroundColor(Color(Asset.Colors.elementBackgroundColor.color))
                .padding(Paddings.padding4)
                .padding(.horizontal, Paddings.padding8)
                .background {
                    Capsule()
                        .fill(Color(Asset.Colors.borderColor.color))
                }

        }
    }

    init(text: String) {
        self.text = text.count < 2 ? text + " " : text
    }

}

struct SliderPointView_Previews: PreviewProvider {
    static var previews: some View {
        SliderPointView(text: "1")
            .background(Color.blue)
    }
}
