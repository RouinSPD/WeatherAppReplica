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

struct Wind {
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
