//
//  BackgroundView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 29/05/24.
//

import SwiftUI

struct BackgroundView: View {
    var dayTime : Bool
    var currentWeatherSymbol : String
    // Cloud data with different starting offsets and durations
    private let icons: [BackgroundIcon] = [
        BackgroundIcon(id: 1, width: 100, height: 60, yOffset: -300, duration: 50, initialOffset: 0),
        BackgroundIcon(id: 2, width: 160, height: 120, yOffset: 0, duration: 40, initialOffset: UIScreen.main.bounds.width * 0.5),
        BackgroundIcon(id: 3, width: 150, height: 90, yOffset: 200, duration: 60, initialOffset: UIScreen.main.bounds.width)
    ]

    var body: some View {
        ZStack {
            (dayTime ? Color.blue.opacity(0.85) : Color.blue.opacity(0.1))
                .edgesIgnoringSafeArea(.all) // Blue background
            
            ForEach(icons) { icon in
                WeatherBackgroundIconView(icon: icon, currentWeatherSymbol: currentWeatherSymbol )
            }
        }//.accessibilityElement(children: .ignore)
    }
}

#Preview {
    BackgroundView(dayTime: false, currentWeatherSymbol: "cloud")
}
