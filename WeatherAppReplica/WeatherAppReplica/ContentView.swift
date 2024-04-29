//
//  ContentView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 25/04/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

class LocationManager: NSObject, ObservableObject{
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else  {return}
        
        DispatchQueue.main.async{
            self.currentLocation = location
        }
    }
}

struct ContentView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private  var weather : Weather?
    
    var hourlyWeatherData: [HourWeather]{
        if let weather{
            return Array(weather.hourlyForecast.filter{ hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        }else{
            return[]
        }
    }
    
    var body: some View {
        VStack {
            if let weather {
                Text("Houston")
                    .font(.largeTitle)
                Text("\(weather.currentWeather.temperature.formatted())")
                ScrollView {
                    HourlyForecastView(hourlyForecast: hourlyWeatherData, weather: weather)
                    TenDayForecastView(daysForecast: weather.dailyForecast.forecast)
                }
            }
            //Spacer()
        }
        //.padding()
        .task(id: locationManager.currentLocation) {
            do{
                if let location = locationManager.currentLocation{
                    self.weather = try await weatherService.weather(for: location)
                    print(weather)
                }
            }
            catch{
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
