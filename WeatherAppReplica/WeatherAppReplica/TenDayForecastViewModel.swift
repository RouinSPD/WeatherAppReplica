//
//  TenDayForecastViewModel.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 29/04/24.
//

import SwiftUI
import WeatherKit

class TenDayForecastViewModel: ObservableObject {
    @Published var daysForecast: [DayWeather] = [] {
        didSet {
            calculateTemperatureExtremes()
        }
    }
    var maxTemp: Double = -1000
    var minTemp: Double = 1000

    private func calculateTemperatureExtremes() {
        maxTemp = daysForecast.max(by: { $0.highTemperature.value < $1.highTemperature.value })?.highTemperature.value ?? -1000
        minTemp = daysForecast.min(by: { $0.lowTemperature.value < $1.lowTemperature.value })?.lowTemperature.value ?? 1000
    }
}
