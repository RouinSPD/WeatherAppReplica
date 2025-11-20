//
//  WeatherProtocol.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 20/11/25.
//

import Foundation
import CoreLocation
import WeatherKit

protocol WeatherProtocol{
    func weather(for location: CLLocation) async throws -> Weather
}
