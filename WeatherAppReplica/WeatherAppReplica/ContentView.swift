//
//  ContentView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 25/04/24.
//

import SwiftUI
import CoreLocation
import WeatherKit


struct ContentView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @StateObject private  var weatherViewModel = WeatherViewModel()
    
    
    //    var hourlyWeatherData: [HourWeather]{
    //        if let weather{
    //            return Array(weather.hourlyForecast.filter{ hourlyWeather in
    //                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
    //            }.prefix(24))
    //        }else{
    //            return[]
    //        }
    //    }
    
    var body: some View {
        ZStack{
            let dayTime = weatherViewModel.isPastSunrise() && !weatherViewModel.isPastSunset()
            BackgroundView(dayTime: dayTime, currentWeatherSymbol: weatherViewModel.currentConditions.symbol)
        VStack {
            if weatherViewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                location
                Text("\(Int(weatherViewModel.currentConditions.temperature))°C | \(weatherViewModel.currentConditions.description)")
                    .foregroundStyle(.white)
                Text("Wind: \(weatherViewModel.wind.compassDirection)")
                    .foregroundStyle(.white)
                
                ScrollView {
                    HourlyForecastView(hourlyForecast: weatherViewModel.hourlyForecasts,  currentTemperature: weatherViewModel.currentConditions.temperature, currentWeatherSymbol: weatherViewModel.currentConditions.symbol)
                    let (maxTemp, minTemp) = weatherViewModel.dailyForecasts.temperatureExtremes()
                    TenDayForecastView(daysForecast: weatherViewModel.dailyForecasts, maxTemp: maxTemp, minTemp: minTemp, currentTemperature: weatherViewModel.currentConditions.temperature)
                    
                    HStack(spacing:15){
                        FeelsLikeView(feelsLikeDescription: weatherViewModel.currentConditions.feelsLike, currentTemperature: weatherViewModel.currentConditions.temperature)
                        HumidityView(humidity: weatherViewModel.humidity.humidity, dewPoint: weatherViewModel.humidity.dewPoint)
                    }
                    HStack(spacing: 15){
                        VisibilityView(visibility: weatherViewModel.currentConditions.visibility)
                        //                        CompassView(direction: "WSW")
                        UVIndexView(uvIndexValue: weatherViewModel.uvIndex.value, uvIndexDescription: weatherViewModel.uvIndex.description)
                    }
                }
                
                //Spacer()
            }
        }
        .padding(.top)
    }
        //.padding()
        .onAppear {
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.currentLocation) { newLocation in
            if let location = newLocation {
                Task{
                    await weatherViewModel.fetchWeatherData(for: location)
                }
            }
        }
        
    }
    
    var location: some View{
        VStack {
            if let location = locationManager.currentLocation {
                if let cityName = locationManager.cityName {
                    Text("\(cityName)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            } else {
                Text("Locating...")
            }
        }
    }
}

#Preview {
    ContentView()
}
