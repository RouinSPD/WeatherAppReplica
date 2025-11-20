//
//  WeatherKitService.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation
import CoreLocation
import WeatherKit

class WeatherKitService: WeatherProtocol{
    private let service = WeatherService()
    func weather(for location: CLLocation) async throws -> Weather {
        try await service.weather(for: location)
    }
}
