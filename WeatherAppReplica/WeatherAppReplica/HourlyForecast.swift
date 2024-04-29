//
//  HourlyForecast.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 27/04/24.
//

import SwiftUI

struct HourForecast: Identifiable {
    var id = UUID()
    var hour: String
    var icon: String
    var temperature: String
    var precipitationProbability: Int?
    var accesibilityText : String
}
