//
//  MockWeatherService.swift
//  WeatherAppReplicateTests
//
//  Created by Pedro Daniel Rouin Salazar on 22/11/25.
//

import Foundation
import CoreLocation
import WeatherKit
@testable import WeatherAppReplica

/// A mock implementation of `WeatherProtocol` used for unit testing.
///
/// This mock is not intended to return actual weather data. Instead,
/// test cases should inject custom values directly into the view model.
///
/// - Note: If needed to simulate `WeatherKit` behavior in integration tests,
/// this mock can be extended to return predefined values or custom test objects.
final class MockWeatherService: WeatherProtocol {
    
    /// Not implemented. Calling this method will result in a runtime failure.
    ///
    /// Exists only to fulfill the `WeatherProtocol` requirement. In unit tests,
    /// the view model should be populated manually with controlled data.
    func weather(for location: CLLocation) async throws -> Weather {
        fatalError("MockWeatherService.weather(for:) is not implemented. Inject test data directly into the view model.")
    }
}



