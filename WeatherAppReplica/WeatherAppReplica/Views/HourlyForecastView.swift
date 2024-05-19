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
    
    var body: some View {
        ZStack {
            //Color(.blue)
            //Image("pinkSky")
            VStack{
                
                TitleView(title: "Hourly forecast", imageName: "clock")
                    .padding(.horizontal)
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
