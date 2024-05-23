//
//  DayForecastView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 28/04/24.
//

import SwiftUI
import WeatherKit
struct DayForecastView: View {
    
    var dayWeather:  DayWeather
    let minScaleTemp : Double // Minimum temperature for the scale
    let maxScaleTemp : Double   // Maximum temperature for the scale
    let currentTemperature : Double
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading){
                Text(dayWeather.date.formatAbbreviatedDay())
                    .font(.title3)
                    .fontWeight(.medium)
                    .frame(width: UIScreen.screenWidth/8)//sets the frame for the text
                    Spacer()
                
            }
          Spacer()
            
            VStack(spacing: 0) {  // VStack for icon and precipitation probability
                Image(systemName: ("\(dayWeather.symbolName).fill"))
                    .symbolRenderingMode(.multicolor)
                //.accessibilityLabel(weather.accesibilityText)
                // Only show precipitation if it exists
                //                    if let precipitation = weather.precipitationProbability {
                //                        Text("\(precipitation)%")
                //                            .font(.caption)
                //                            .foregroundStyle(.cyan)
                //                            .bold()
                //                    }
                    .frame(width: UIScreen.screenWidth/16)
            }
            
            Spacer()
            
            HStack{
                Spacer()
                // Temperature values
                Text((dayWeather.lowTemperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
                    .font(.title3)
                    .opacity(0.5)
                    .frame(width: 40)
                // .accessibilityLabel(Text("\(weather.temperatureLow)° low"))
                // Spacer()
                
                // Temperature bar
                TemperatureBar(lowTemperature: dayWeather.lowTemperature.value, highTemperature: dayWeather.highTemperature.value, currentTemperature: currentTemperature, minScaleTemp: minScaleTemp, maxScaleTemp: maxScaleTemp)
                    .frame(height: 8)
                //.fixedSize(horizontal: false, vertical: true)
                
                Text((dayWeather.highTemperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width: 50)
                //.accessibilityLabel(Text("\(weather.temperatureHigh)° high"))
                
            }
            .frame(width: UIScreen.screenWidth/2)
            // Spacer()
        }
        //.padding(.trailing,5)
        //.accessibilityLabel(Text(weather.accesibilityText))
        //.accessibilityElement(children: .combine)
        //
    }
}


//#Preview {
//    DayForecastView()
//}
