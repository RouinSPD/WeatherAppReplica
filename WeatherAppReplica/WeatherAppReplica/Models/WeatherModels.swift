//
//  WeatherModels.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation

/// Represents the current weather conditions, including temperature,
/// symbolic representation, visibility, and precipitation.
struct CurrentConditions: Equatable {
    
    /// Textual description of the current weather
    /// (e.g., "Sunny", "Cloudy", "Partly Cloudy").
    var description: String

    /// Current temperature in Celsius.
    var temperature: Double

    /// The SF Symbol name representing the current weather
    /// (e.g., `"cloud.sun.fill"`).
    var symbol: String

    /// "Feels like" temperature in Celsius.
    var feelsLike: Double

    /// Current precipitation intensity in mm/h (rounded to an integer).
    var precipitation: Int

    /// Current visibility in kilometers (rounded to an integer).
    var visibility: Int

    /// An empty instance used as an initial placeholder
    /// before real weather data has been loaded.
    static let empty = CurrentConditions(
        description: "",
        temperature: 0,
        symbol: "",
        feelsLike: 0,
        precipitation: 0,
        visibility: 0
    )
}

/// Represents information about the current wind conditions,
/// including speed, gusts, and compass direction.
struct WindInfo: Equatable {

    /// Wind speed in km/h (rounded).
    var speed: Int

    /// Maximum wind gust, if available, in km/h (rounded).
    var gust: Int

    /// Compass direction abbreviation (e.g., `"NE"`, `"SW"`).
    var compassDirection: String

    /// An empty placeholder instance used prior to receiving real wind data.
    static let empty = WindInfo(speed: 0, gust: 0, compassDirection: "")
}

/// Represents sunrise and sunset times for the current location.
struct Sun: Equatable {

    /// Sunrise time as a `Date`, if available.
    var sunrise: Date?

    /// Sunset time as a `Date`, if available.
    var sunset: Date?

    /// An empty value used before sunrise/sunset data becomes available.
    static let empty = Sun(sunrise: nil, sunset: nil)
}

/// Represents humidity-related weather measurements,
/// including relative humidity and dew point.
struct HumidityInfo: Equatable {

    /// Relative humidity percentage (0–100).
    var humidity: Int

    /// Dew point temperature in Celsius (rounded).
    var dewPoint: Int

    /// An empty placeholder value for initialization.
    static let empty = HumidityInfo(humidity: 0, dewPoint: 0)
}

/// Represents the UV index information, including
/// the numeric value and category description.
struct UVIndexInfo: Equatable {

    /// Numeric UV index value (commonly between 0 and 11+).
    var value: Int

    /// Descriptive category (e.g., `"Moderate"`, `"High"`, `"Extreme"`).
    var description: String

    /// Empty placeholder value for initialization before real data arrives.
    static let empty = UVIndexInfo(value: 0, description: "")
}


