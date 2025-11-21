//
//  WeatherViewModel.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 30/04/24.
//

import Foundation
import WeatherKit
import CoreLocation

/// A view model responsible for fetching, processing, and exposing
/// weather data to SwiftUI views.
///
/// `WeatherViewModel` coordinates data loading from a service conforming
/// to ``WeatherProtocol``, transforms WeatherKit models into app‑specific
/// models, and updates its published properties on the main actor.
///
/// This class is annotated with `@MainActor` to guarantee UI‑safe updates.
///
/// Usage example:
/// ```swift
/// let viewModel = WeatherViewModel()
/// await viewModel.fetchWeatherData(for: someCLLocation)
/// ```
///
@MainActor
class WeatherViewModel : ObservableObject{
    
    // MARK: - Dependencies
        
        /// The weather service used to retrieve weather information.
        ///
        /// Defaults to ``WeatherKitService`` but can be replaced with a mock
        /// implementation during testing.
    private let service: WeatherProtocol
    
    // MARK: - Published Properties
        
    /// Hour‑by‑hour weather forecast starting from the current time.
    @Published var hourlyForecasts : [HourWeather] = []
    
    /// Daily weather forecast data.
    @Published var dailyForecasts : [DayWeather] = []
    
    /// Indicates whether the view model is in the process of loading data.
    @Published var isLoading : Bool = false
    
    /// Stores an error message when a request fails.
    @Published var errorMessage : String?
    
    /// High‑level current conditions (temperature, description, symbol, etc.).
    @Published var currentConditions: CurrentConditions = CurrentConditions.empty
    
    /// UV index information (value + descriptive category).
    @Published var uvIndex: UVIndexInfo = UVIndexInfo.empty
    
    /// Humidity and dew point information.
    @Published var humidity: HumidityInfo = HumidityInfo.empty
    
    /// Wind information (speed, gusts, compass direction).
    @Published var wind: WindInfo = WindInfo.empty
    
    /// Sunrise and sunset times for the current location.
    @Published var sun: Sun = Sun.empty
    
    // MARK: - Initialization
        
    /// Creates a new weather view model with an optional injected weather service.
    ///
    /// - Parameter service: A type conforming to ``WeatherProtocol``.
    ///   Defaults to ``WeatherKitService``.
    init(service: WeatherProtocol = WeatherKitService()){
        self.service = service
    }
    
    // MARK: - Data Fetching
       
    /// Fetches weather data for the specified location using the injected service.
    ///
    /// This method:
    /// - Sets loading state
    /// - Performs an async call to the WeatherKit API
    /// - Updates all published weather properties
    /// - Handles and exposes errors to the UI
    ///
    /// - Parameter location: A `CLLocation` representing the user's coordinates.
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
    
    // MARK: - Weather Processing
        
    /// Updates all current‑weather‑related properties from WeatherKit's `CurrentWeather`.
    ///
    /// - Parameter current: The `CurrentWeather` model returned by WeatherKit.
    private func updatCurrentConditions(_ current: CurrentWeather){
        updateCurrentWeatherInfo(from: current)
        updateWind(from: current.wind)
        updateUVIndex(from: current.uvIndex)
        updateHumidity(from: current)
    }
    
    /// Extracts and assigns wind‑related values.
    ///
    /// - Parameter wind: The `Wind` object from WeatherKit.
    private func updateWind(from wind: Wind){
        self.wind.compassDirection = wind.compassDirection.abbreviation
        self.wind.speed = Int(wind.speed.value.rounded())
        self.wind.gust = Int(wind.gust?.value.rounded() ?? 0)
    }
    
    /// Updates the UV index information.
    ///
    /// - Parameter uvIndex: The `UVIndex` object from WeatherKit.
    private func updateUVIndex(from uvIndex: UVIndex){
        self.uvIndex.value = uvIndex.value
        self.uvIndex.description = uvIndex.category.description
    }
    
    /// Updates humidity and dew point information.
    ///
    /// - Parameter current: The `CurrentWeather` object.
    private func updateHumidity(from current: CurrentWeather){
        self.humidity.humidity = Int(current.humidity*100)
        self.humidity.dewPoint =  Int(current.dewPoint.value.rounded())
    }
    
    /// Updates high‑level current weather conditions such as description,
    /// temperature, precipitation, and visibility.
    ///
    /// - Parameter current: The `CurrentWeather` model.
    private func updateCurrentWeatherInfo(from current: CurrentWeather){
        self.currentConditions.description = current.condition.description
        self.currentConditions.temperature = current.temperature.value
        self.currentConditions.symbol = current.symbolName
        self.currentConditions.feelsLike = current.apparentTemperature.value
        self.currentConditions.visibility = Int((current.visibility.value/1000).rounded())
        self.currentConditions.precipitation = Int(current.precipitationIntensity.value.rounded())
    }
    
    /// Updates both the daily and hourly forecast arrays.
    ///
    /// Filters hourly forecasts to include only the next 24 hours.
    ///
    /// - Parameter weather: The full `Weather` object returned by WeatherKit.
    private func updateForecastData(_ weather: Weather){
        //creates a unique date for that moment
        let now = Date()
        self.dailyForecasts = weather.dailyForecast.forecast
        self.hourlyForecasts = Array(weather.hourlyForecast.forecast
            .filter {$0.date >= now}
            .prefix(24))
    }
    
    /// Updates sunrise and sunset information from the first daily forecast.
    ///
    /// - Parameter dayWeather: A `DayWeather` object for the current day, or `nil`.
    private func updateSunInfo(_ dayWeather: DayWeather?){
        guard let dayWeather = dayWeather else{
            self.sun.sunrise = nil
            self.sun.sunset = nil
            return
        }
        self.sun.sunrise = dayWeather.sun.sunrise
        self.sun.sunset = dayWeather.sun.sunset
    }
    
    /// Returns whether the current time has passed today's sunset.
    ///
    /// This method checks the `sun.sunset` value provided by the weather service.
    /// If the sunset time is unavailable, the method safely returns `false`.
    ///
    /// - Returns: `true` if the current time is later than today's sunset; otherwise, `false`.
    func isPastSunset() -> Bool {
        guard let sunsetTime = sun.sunset else { return false }
        return Date() > sunsetTime
    }

    /// Returns whether the current time has passed today's sunrise.
    ///
    /// This method checks the `sun.sunrise` value provided by the weather service.
    /// If the sunrise time is unavailable, the method safely returns `false`.
    ///
    /// - Returns: `true` if the current time is later than today's sunrise; otherwise, `false`.
    func isPastSunrise() -> Bool {
        guard let sunriseTime = sun.sunrise else { return false }
        return Date() > sunriseTime
    }
    
}
