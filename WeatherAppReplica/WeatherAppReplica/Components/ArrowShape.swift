//
//  ArrowShape.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 21/05/24.
//

import SwiftUI

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - 5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + 5, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
