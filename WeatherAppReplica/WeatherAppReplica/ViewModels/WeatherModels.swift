//
//  WeatherModels.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation

struct CurrentConditions {
    var temperature: Double
    var symbol: String
    var description: String
}

struct WindInfo {
    var speed: Int
    var gust: Int
    var compassDirection: String
}

struct Sun{
    var sunrise: Date?
    var sunset: Date?
}

struct Humidity {
    var humidity: Int
    var dewPoint: Int
}

struct UVIndexInfo {
    var value: Int
    var description: String
}

struct CurrentWeatherInfo{
    var description: String
    var temperature: Double
    var symbol: String
    var feelsLike: Double
    var precipitation: Int
    var visibility: Int
}
