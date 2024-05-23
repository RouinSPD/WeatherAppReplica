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
    var currentTemperature : Double
    var currentWeatherSymbol : String
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
                        currentHour
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
    var currentHour : some View{
        VStack{
            Text("Now")
                .foregroundColor(.white)
                .font(.headline)
            
            Image(systemName: ("\(currentWeatherSymbol).fill"))
                .symbolRenderingMode(.multicolor)
                .font(.title3)
                .frame(width: UIScreen.screenWidth/16)
                .padding(.vertical,5)
           // Text((hourWeather.temperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
            Text("\(Int(currentTemperature.rounded()))°")
                .foregroundColor(.white)
                .font(.headline)
            
        }
        //.accessibilityElement(children: .combine)
        .padding(.horizontal, 7)
    }
}

//#Preview {
//    HourlyForecastView(hourlyForecast: )
//}
