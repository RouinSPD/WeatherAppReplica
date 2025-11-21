//
//  WeatherViewModel.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 30/04/24.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor
class WeatherViewModel : ObservableObject{
    
    private let service: WeatherProtocol
    
    //MARK: Properties
    @Published var hourlyForecasts : [HourWeather] = []
    @Published var dailyForecasts : [DayWeather] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String?
    @Published var currentWeatherInfo: CurrentWeatherInfo = CurrentWeatherInfo(description: "", temperature: 0, symbol: "", feelsLike: 0, precipitation: 0, visibility: 0)
    @Published var uvIndex: UVIndexInfo = UVIndexInfo(value: 0, description: "")
    @Published var humidity: Humidity = Humidity(humidity: 0, dewPoint: 0)
    @Published var wind: WindInfo = WindInfo(speed: 0, gust: 0, compassDirection: "")
    @Published var sun: Sun = Sun()
    
//    // var cancellables = Set<AnyCancellable>()
//    private var weatherService = WeatherService()
    
    init(service: WeatherProtocol = WeatherKitService()){
        self.service = service
    }
    
    func fetchWeatherData(for location: CLLocation) async{
        isLoading = true
        errorMessage = nil
            do{
                let weather = try await service.weather(for: location)
                self.updatCurrentConditions(weather.currentWeather)
                self.updateForecastData(weather)
                self.updateSunInfo(weather.dailyForecast.first)
                self.isLoading = false
            }
            catch{
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
            }
    }
    
    
    private func updatCurrentConditions(_ current: CurrentWeather){
        updateCurrentWeatherInfo(from: current)
        updateWind(from: current.wind)
        updateUVIndex(from: current.uvIndex)
        updateHumidity(from: current)
    }
    
    private func updateWind(from wind: Wind){
        self.wind.compassDirection = wind.compassDirection.abbreviation
        self.wind.speed = Int(wind.speed.value.rounded())
        self.wind.gust = Int(wind.gust?.value.rounded() ?? 0)
    }
    
    private func updateUVIndex(from uvIndex: UVIndex){
        self.uvIndex.value = uvIndex.value
        self.uvIndex.description = uvIndex.category.description
    }
    
    private func updateHumidity(from current: CurrentWeather){
        self.humidity.humidity = Int(current.humidity*100)
        self.humidity.dewPoint =  Int(current.dewPoint.value.rounded())
    }
    
    private func updateCurrentWeatherInfo(from current: CurrentWeather){
        self.currentWeatherInfo.description = current.condition.description
        self.currentWeatherInfo.temperature = current.temperature.value
        self.currentWeatherInfo.symbol = current.symbolName
        self.currentWeatherInfo.feelsLike = current.apparentTemperature.value
        self.currentWeatherInfo.visibility = Int((current.visibility.value/1000).rounded())
        self.currentWeatherInfo.precipitation = Int(current.precipitationIntensity.value.rounded())
    }
    
    private func updateForecastData(_ weather: Weather){
        //creates a unique date for that moment
        let now = Date()
        self.dailyForecasts = weather.dailyForecast.forecast
        self.hourlyForecasts = Array(weather.hourlyForecast.forecast
            .filter {$0.date >= now}
            .prefix(24))
    }
    
    private func updateSunInfo(_ dayWeather: DayWeather?){
        guard let dayWeather = dayWeather else{
            self.sun.sunrise = nil
            self.sun.sunset = nil
            return
        }
        self.sun.sunrise = dayWeather.sun.sunrise
        self.sun.sunset = dayWeather.sun.sunset
    }
    
    func temperatureExtremes() -> (maxTemp: Double, minTemp: Double){
        let maxT = dailyForecasts.max(by: {$0.highTemperature.value < $1.highTemperature.value})?.highTemperature.value ?? 50.0
        let minT = dailyForecasts.min(by: {$0.lowTemperature.value < $1.lowTemperature.value})?.lowTemperature.value ?? 0.0
        return(maxTemp: maxT, minTemp: minT)
    }
    
    func isPastSunset() -> Bool {
        guard let sunsetTime = sun.sunset else { return false }
        return Date() > sunsetTime
    }
    func isPastSunrise() -> Bool {
        guard let sunriseTime = sun.sunrise else {return false}
        return Date() > sunriseTime
    }
    
}
