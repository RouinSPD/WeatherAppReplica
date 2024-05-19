//
//  ColorBar.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct ColorBar: View {
    var multiplier: Int

        var body: some View {
            GeometryReader { geo in
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red, .purple]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 4)
                    .overlay(
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 12, height: 4)
                            .offset(x: (geo.size.width / 10) * CGFloat((multiplier-5)))
                            .overlay(
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 4)
                                    .offset(x: (geo.size.width / 10) * CGFloat((multiplier-5)))
                            )
                    )
            }
            .frame(height: 4) 
        }
}

#Preview {
    ColorBar(multiplier: 8)
}
