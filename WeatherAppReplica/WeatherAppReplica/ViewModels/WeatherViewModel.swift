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
    @Published var currentTemperature : Double = 0
    @Published var currentWeatherSymbol : String = ""
    @Published var humidity : Int = 0
    @Published var dewPointDescription : Int = 0
    @Published var feelsLikeDescription : Double = 0
    @Published var visibilityValue : Int = 0
    @Published var uvIndexValue : Int = 0
    @Published var uvIndexDescription : String = ""
    @Published var windSpeed : Int = 0
    @Published var windGust : Int = 0
    @Published var windCompassDirection : String = ""
    @Published var precipitation : Int = 0
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
                    self?.hourlyForecasts = Array(weather.hourlyForecast.forecast.filter {
                        $0.date >= Date()
                    }.prefix(24).map { $0 } )
                    self?.currentTemperature = weather.currentWeather.temperature.value
                    self?.currentWeatherSymbol = weather.currentWeather.symbolName
                    self?.humidity = Int(weather.currentWeather.humidity*100)
                    self?.dewPointDescription =  Int(weather.currentWeather.dewPoint.value.rounded())
                    self?.feelsLikeDescription = weather.currentWeather.apparentTemperature.value
                    self?.visibilityValue = Int((weather.currentWeather.visibility.value/1000).rounded())
                    self?.uvIndexValue = weather.currentWeather.uvIndex.value
                    self?.uvIndexDescription = weather.currentWeather.uvIndex.category.description
//                    weather.currentWeather.cloudCover.animatableData
//                    weather.currentWeather.precipitationIntensity.
                    self?.windSpeed = Int(weather.currentWeather.wind.speed.value.rounded())
                    if let windGust = weather.currentWeather.wind.gust{
                        self?.windGust = Int(windGust.value.rounded())
                    }
                    self?.windCompassDirection = weather.currentWeather.wind.compassDirection.abbreviation
                    self?.precipitation = Int(weather.currentWeather.precipitationIntensity.value.rounded())
                   
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
