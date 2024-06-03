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
            BackgroundView(dayTime: dayTime, currentWeatherSymbol: weatherViewModel.currentWeatherSymbol)
        VStack {
            if weatherViewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                location
                Text("\(Int(weatherViewModel.currentTemperature))°C | \(weatherViewModel.weatherDescription)")
                    .foregroundStyle(.white)
                Text("Wind: \(weatherViewModel.windCompassDirection)")
                    .foregroundStyle(.white)
                
                ScrollView {
                    HourlyForecastView(hourlyForecast: weatherViewModel.hourlyForecasts,  currentTemperature: weatherViewModel.currentTemperature, currentWeatherSymbol: weatherViewModel.currentWeatherSymbol)
                    let (maxTemp, minTemp) = weatherViewModel.temperatureExtremes()
                    TenDayForecastView(daysForecast: weatherViewModel.dailyForecasts, maxTemp: maxTemp, minTemp: minTemp, currentTemperature: weatherViewModel.currentTemperature)
                    
                    HStack(spacing:15){
                        FeelsLikeView(feelsLikeDescription: weatherViewModel.feelsLikeDescription, currentTemperature: weatherViewModel.currentTemperature)
                        HumidityView(humidity: weatherViewModel.humidity, dewPoint: weatherViewModel.dewPointDescription)
                    }
                    HStack(spacing: 15){
                        VisibilityView(visibility: weatherViewModel.visibilityValue)
                        //                        CompassView(direction: "WSW")
                        UVIndexView(uvIndexValue: weatherViewModel.uvIndexValue, uvIndexDescription: weatherViewModel.uvIndexDescription)
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
                weatherViewModel.fetchWeatherData(for: location)
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
