//
//  WeatherViewModel.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 30/04/24.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel : ObservableObject{
    //MARK: Properties
    @Published var hourlyForecasts : [HourWeather] = []
    @Published var dailyForecasts : [DayWeather] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String?
    @Published var weatherDescription : String = ""
    
    
    // var cancellables = Set<AnyCancellable>()
    private var weatherService = WeatherService()
    
    init(){
        weatherService = WeatherService()
    }
    
    func fetchWeatherData(for location: CLLocation){
        isLoading = true
        errorMessage = nil
        
        Task{
            do{
                let weather = try await weatherService.weather(for: location)
                DispatchQueue.main.async{ [weak self] in
                    //self?.weather = weather
                    self?.weatherDescription = weather.currentWeather.condition.description
                    self?.isLoading = false
                    self?.dailyForecasts = weather.dailyForecast.forecast
                    self?.hourlyForecasts = weather.hourlyForecast.forecast
                    
                }
            }
            catch{
                DispatchQueue.main.async{ [weak self] in
                    self?.isLoading = false
                    self?.errorMessage = error.localizedDescription
                    
                }
                
            }
        }
    }
    
    func temperatureExtremes() -> (maxTemp: Double, minTemp: Double){
        var maxT = dailyForecasts.max(by: {$0.highTemperature.value < $1.highTemperature.value})?.highTemperature.value ?? 50.0
        var minT = dailyForecasts.min(by: {$0.lowTemperature.value < $1.lowTemperature.value})?.lowTemperature.value ?? 0.0
        return(maxTemp: maxT, minTemp: minT)
    }
    
}
