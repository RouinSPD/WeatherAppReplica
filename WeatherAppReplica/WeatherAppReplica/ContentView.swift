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
        VStack {
            
            Text("Houston")
                .font(.largeTitle)
            //                Text("\(weatherViewModel.currentWeather.temperature.formatted())")
            ScrollView {
                HourlyForecastView(hourlyForecast: weatherViewModel.hourlyForecasts, weather: weatherViewModel.weatherDescription)
                TenDayForecastView(daysForecast: weatherViewModel.dailyForecasts)
            }
            
            //Spacer()
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
}

#Preview {
    ContentView()
}
