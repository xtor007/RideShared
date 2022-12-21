//
//  Hexagon.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 21.12.2022.
//

import SwiftUI

struct Hexagon: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let shift: CGFloat = 20
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + shift, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - shift, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - shift, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + shift, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        return path
    }

}
