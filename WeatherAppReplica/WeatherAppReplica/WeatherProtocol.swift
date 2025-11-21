//
//  WeatherProtocol.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation
import CoreLocation
import WeatherKit

/// A protocol that defines the requirements for fetching weather data.
///
/// Conforming types must implement a method to retrieve `Weather` information
/// asynchronously for a specified geographic location.
protocol WeatherProtocol {

    /// Retrieves weather data for the given location.
    ///
    /// This asynchronous method should return comprehensive weather information,
    /// including current conditions, hourly, and daily forecasts.
    ///
    /// - Parameter location: A `CLLocation` representing the geographic coordinates for which weather data is requested.
    /// - Returns: A `Weather` object containing weather information for the given location.
    /// - Throws: An error if the weather data could not be retrieved.
    func weather(for location: CLLocation) async throws -> Weather
}
