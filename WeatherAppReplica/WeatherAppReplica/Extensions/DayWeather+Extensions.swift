//
//  DayWeather+Extensions.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation
import WeatherKit

extension Array where Element == DayWeather {
    /// Returns the maximum and minimum temperatures from the daily forecast.
        ///
        /// This function iterates through the array of `DayWeather` elements and extracts the highest and lowest temperatures.
        /// If the array is empty or values are missing, it defaults to `50.0` for the maximum temperature and `0.0` for the minimum.
        ///
        /// - Returns: A tuple containing:
        ///   - `maxTemp`: The highest temperature found in the array.
        ///   - `minTemp`: The lowest temperature found in the array.
        ///
        /// ## Example
        /// ```swift
        /// let extremes = forecast.temperatureExtremes()
        /// print("Max: \(extremes.maxTemp), Min: \(extremes.minTemp)")
        /// ```
    func temperatureExtremes() -> (maxTemp: Double, minTemp: Double){
        let maxT = self.max(by: {$0.highTemperature.value < $1.highTemperature.value})?.highTemperature.value ?? 50.0
        let minT = self.min(by: {$0.lowTemperature.value < $1.lowTemperature.value})?.lowTemperature.value ?? 0.0
        return(maxTemp: maxT, minTemp: minT)
    }
}
