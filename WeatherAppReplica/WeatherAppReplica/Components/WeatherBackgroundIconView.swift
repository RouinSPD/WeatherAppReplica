//
//  WeatherBackgroundIconView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 29/05/24.
//

import SwiftUI


 
struct BackgroundIcon: Identifiable {
    let id: Int
    let width: CGFloat
    let height: CGFloat
    let yOffset: CGFloat
    let duration: Double
    let initialOffset: CGFloat
}

struct WeatherBackgroundIconView: View {
    let icon: BackgroundIcon
    var currentWeatherSymbol : String
    @State private var movingOffset: CGFloat

    init(icon: BackgroundIcon, currentWeatherSymbol: String) {
        self.icon = icon
        self.currentWeatherSymbol = currentWeatherSymbol
        _movingOffset = State(initialValue: icon.initialOffset)
    }

    var body: some View {
        Image(systemName: "\(currentWeatherSymbol).fill")
            .resizable()
            .scaledToFit()
            .frame(width: icon.width, height: icon.height)
            .symbolRenderingMode(.multicolor).opacity(0.5)
            .offset(x: movingOffset, y: icon.yOffset)
            .onAppear {
                startMovingIcon()
            }
    }

    private func startMovingIcon() {
        let screenWidth = UIScreen.main.bounds.width
        let totalDistance = screenWidth + icon.width * 2 // Ensuring it goes completely off-screen

        withAnimation(Animation.linear(duration: icon.duration).repeatForever(autoreverses: false)) {
            movingOffset = -totalDistance
        }
    }
}
#Preview {
    WeatherBackgroundIconView(icon: BackgroundIcon(id: 1, width: 100, height: 60, yOffset: -300, duration: 50, initialOffset: 0), currentWeatherSymbol: "cloud")
}
