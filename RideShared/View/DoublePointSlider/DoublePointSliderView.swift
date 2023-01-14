//
//  DoublePointSliderView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct DoublePointSliderView: View {

    let data: ClosedRange<Int>
    @Binding var leftIndex: Int
    @Binding var rightIndex: Int

    @State var leftPosition: Double
    @State var rightPosition: Double

    @State var leftTranslation = 0.0
    @State var rightTranslation = 0.0

    @State var rightName: String
    @State var leftName: String

    let minDistance: Double

    var currentLeftIndex: Int {
        let index = (leftPosition + leftTranslation) * Double(data.count)
        return Int(index - 0.5) + data.lowerBound
    }

    var currentRightIndex: Int {
        let index = (rightPosition + rightTranslation) * Double(data.count)
        return Int(index - 0.5) + data.lowerBound
    }

    var body: some View {
        GeometryReader { geo in

            let minValue = 0.0
            let maxValue = geo.size.width - DoubleSliderConstants.pointSize

            ZStack(alignment: .leading) {

                Capsule()
                    .fill(Color(Asset.Colors.elementBackgroundColor.color))
                    .frame(height: DoubleSliderConstants.lineHeight)

                Capsule()
                    .fill(Color(Asset.Colors.borderColor.color))
                    .frame(
                        width: (rightPosition - leftPosition + rightTranslation - leftTranslation)
                        * (maxValue - minValue),
                        height: DoubleSliderConstants.lineHeight
                    )
                    .offset(x: (leftPosition + leftTranslation) * (maxValue - minValue))

                SliderPointView(text: rightName)
                    .offset(
                        x: (rightPosition + rightTranslation) * (maxValue - minValue) - Paddings.padding10,
                        y: DoubleSliderConstants.triangleSize
                        + DoubleSliderConstants.triangleTopDistande
                        + DoubleSliderConstants.pointSize / 2
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { vertical in
                                let newCoordinate =  (maxValue - minValue) * rightPosition + vertical.translation.width
                                let leftAbsolutPosition = leftPosition * (maxValue - minValue)
                                let absoluteMinDistance = minDistance * (maxValue - minValue)
                                if (leftAbsolutPosition + absoluteMinDistance)...maxValue ~= newCoordinate {
                                    rightTranslation = vertical.translation.width / (maxValue - minValue)
                                } else {
                                    rightPosition = vertical.translation.width > 0 ? 1.0 : leftPosition + minDistance
                                    rightTranslation = 0
                                }
                                rightName = String(currentRightIndex)
                            }
                            .onEnded({ _ in
                                rightPosition += rightTranslation
                                rightTranslation = 0
                                rightIndex = currentRightIndex
                            })
                    )

                SliderPointView(text: leftName)
                    .offset(
                        x: (leftPosition + leftTranslation)
                        * (maxValue - minValue) - DoubleSliderConstants.triangleSideDistance,
                        y: DoubleSliderConstants.triangleSize
                        + DoubleSliderConstants.triangleTopDistande
                        + DoubleSliderConstants.pointSize / 2
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { vertical in
                                let newCoordinate =  (maxValue - minValue) * leftPosition + vertical.translation.width
                                let rightAbsolutPosition = rightPosition * (maxValue - minValue)
                                let absoluteMinDistance = minDistance * (maxValue - minValue)
                                if minValue...(rightAbsolutPosition - absoluteMinDistance) ~= newCoordinate {
                                    leftTranslation = vertical.translation.width / (maxValue - minValue)
                                } else {
                                    leftPosition = vertical.translation.width > 0 ? rightPosition - minDistance : 0.0
                                    leftTranslation = 0
                                }
                                leftName = String(currentLeftIndex)
                            }
                            .onEnded({ _ in
                                leftPosition += leftTranslation
                                leftTranslation = 0
                                leftIndex = currentLeftIndex
                            })
                    )

            }

        }
        .padding(
            .bottom,
            DoubleSliderConstants.triangleSize
            + DoubleSliderConstants.triangleTopDistande
            + DoubleSliderConstants.pointSize
        )
    }

    init(data: ClosedRange<Int>, leftIndex: Binding<Int>, rightIndex: Binding<Int>) {
        self.data = data
        self._leftIndex = leftIndex
        self._rightIndex = rightIndex
        leftPosition = Double(leftIndex.wrappedValue - data.lowerBound) / Double(data.count)
        rightPosition = Double(rightIndex.wrappedValue - data.lowerBound) / Double(data.count)
        minDistance = 1 / Double(data.count)
        rightName = String(rightIndex.wrappedValue)
        leftName = String(leftIndex.wrappedValue)
    }

}

struct DoublePointSliderView_Previews: PreviewProvider {
    static var previews: some View {
        DoublePointSliderView(data: 18...99, leftIndex: .constant(30), rightIndex: .constant(50))
    }
}
