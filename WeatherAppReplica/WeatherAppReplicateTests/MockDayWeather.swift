//
//  MockDayWeather.swift
//  WeatherAppReplicateTests
//
//  Created by Pedro Daniel Rouin Salazar on 22/11/25.
//

import Foundation

/// A mock struct that represents simplified daily weather data for testing purposes.
struct MockDayWeather {
    let date: Date
    let highTemp: Double
    let lowTemp: Double
}

extension Array where Element == MockDayWeather {
    /// Calculates the highest and lowest temperatures in the mock forecast.
    /// - Returns: A tuple containing the maximum and minimum temperatures.
    func temperatureExtremes() -> (max: Double, min: Double) {
        let maxT = self.max(by: { $0.highTemp < $1.highTemp })?.highTemp ?? 0
        let minT = self.min(by: { $0.lowTemp < $1.lowTemp })?.lowTemp ?? 0
        return (maxT, minT)
    }
}
