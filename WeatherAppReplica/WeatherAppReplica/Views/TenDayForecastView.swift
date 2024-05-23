//
//  TenDayForecastView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 28/04/24.
//

import SwiftUI
import WeatherKit

struct TenDayForecastView: View {
    var daysForecast : [DayWeather]
    var maxTemp: Double
    var minTemp: Double
    var currentTemperature : Double
    
    var body: some View {
        ZStack{
            //Color(.blue)
            VStack(alignment: .leading) {
                HStack {
                    Label {
                        Text("10-DAY FORECAST")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .foregroundColor(.white)
                    
                    Spacer() // Pushes the label to the left
                }
                
                //.padding(.top)
                Divider()
                    .background(.white)
                    .opacity(0.5)
                
                ForEach(daysForecast, id:\.date) { dayForecast in
                    DayForecastView(dayWeather: dayForecast, minScaleTemp: minTemp, maxScaleTemp: maxTemp, currentTemperature: currentTemperature)
//                    DayForecastView(dayWeather: dayForecast, currentTemperature: currentTemperature)
//                    if dayForecast.highTemperature.value > maxTemp {
//                        //maxTemp = dayForecast.highTemperature.value
//                    }
                    Divider()
                        .background(.white)
                        .opacity(0.5)
                    //.accessibilityLabel(Text(hourWeatherItem.accesibilityText))
                }
                
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(20)
            .padding(.horizontal)
            .foregroundColor(.white)
            
            
        }
    }
}


//#Preview {
//    TenDayForecastView()
//}
