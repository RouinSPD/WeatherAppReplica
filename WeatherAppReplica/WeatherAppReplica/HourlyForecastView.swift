//
//  HourlyForecastView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 27/04/24.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    var hourlyForecast : [HourWeather]
    var weather : Weather
    
    var body: some View {
        ZStack {
            //Color(.blue)
            //Image("pinkSky")
            VStack{
                Text("Cloudy conditions expected around 23:00.")
                    
                Text(weather.currentWeather.condition.description)
                    .foregroundColor(.white)
                    .font(.callout)
                Divider()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(hourlyForecast, id:\.date) { hourWeatherItem in
                            HourForecastView(hourWeather: hourWeatherItem)
                            //.accessibilityLabel(Text(hourWeatherItem.accesibilityText))
                        }
                    }
                }
            }.font(.system(size: 12))
                .padding(.vertical,10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray.opacity(0.4))
                )
                .padding()
        }
    }
}

//#Preview {
//    HourlyForecastView(hourlyForecast: )
//}
