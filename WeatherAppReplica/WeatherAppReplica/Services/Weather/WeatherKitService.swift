//
//  WeatherKitService.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation
import CoreLocation
import WeatherKit

/// A concrete implementation of the `WeatherProtocol` using Apple’s `WeatherKit`.
///
/// `WeatherKitService` acts as a bridge between the app and Apple’s `WeatherService`,
/// providing asynchronous weather data retrieval for a given `CLLocation`.
class WeatherKitService: WeatherProtocol {

    /// The underlying WeatherKit service used to fetch weather data.
    private let service = WeatherService()

    /// Asynchronously fetches weather data for the specified location.
    ///
    /// This method uses `WeatherKit.WeatherService` to request comprehensive weather information
    /// such as current conditions, hourly and daily forecasts.
    ///
    /// - Parameter location: The geographical location for which to retrieve the weather.
    /// - Returns: A `Weather` object containing current, hourly, and daily forecasts.
    /// - Throws: An error if the weather data could not be fetched, typically due to network or authorization issues.
    func weather(for location: CLLocation) async throws -> Weather {
        try await service.weather(for: location)
    }
}
