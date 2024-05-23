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
        
        HStack(alignment: .center) {
            dayOfTheWeek
            Spacer()
            WeatherIconView(precipitationChance: dayWeather.precipitationChance, symbolName: dayWeather.symbolName)
            Spacer()
            temperatureBar
        }
        .frame(height: UIScreen.screenHeight/24)
        //.accessibilityLabel(Text(weather.accesibilityText))
        //.accessibilityElement(children: .combine)
        //
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
    
    //MARK: View components
    var dayOfTheWeek : some View {
        HStack(){
            //if it is today change the name of the day for today
            if isToday(date: dayWeather.date){
                Text("Today")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            else{
                Text(dayWeather.date.formatAbbreviatedDay())
                    .font(.title3)
                    .fontWeight(.medium)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth/6)
        
    }
    var weatherIcon : some View {
        // VStack for icon and precipitation probability
        VStack(spacing: 0) {
            if dayWeather.precipitationChance*100 >= 20 && !dayWeather.symbolName.contains("sun.max"){
                Image(systemName: ("\(dayWeather.symbolName).rain.fill"))
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .frame(width: UIScreen.screenWidth/16)
                //.accessibilityLabel(weather.accesibilityText)
                
                // Only show precipitation if it exists
                Text("\(Int(dayWeather.precipitationChance*100))%")
                    .font(.caption)
                    .foregroundStyle(.cyan)
                    .bold()
                //            }
            }
            else {
                Image(systemName: ("\(dayWeather.symbolName).fill"))
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .frame(width: UIScreen.screenWidth/16)
                //.accessibilityLabel(weather.accesibilityText)
            }
        }
    }
    var temperatureBar : some View {
        HStack{
            Spacer()
            // Temperature values
            Text((dayWeather.lowTemperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
                .font(.title3)
                .opacity(0.5)
                .frame(width: 40)
            // .accessibilityLabel(Text("\(weather.temperatureLow)° low"))
            
            // Temperature bar
            TemperatureBar(lowTemperature: dayWeather.lowTemperature.value, highTemperature: dayWeather.highTemperature.value, currentTemperature: currentTemperature, minScaleTemp: minScaleTemp, maxScaleTemp: maxScaleTemp)
                .padding(.vertical, 0)
                .frame(height: 8)
            
            Text((dayWeather.highTemperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 50)
            //.accessibilityLabel(Text("\(weather.temperatureHigh)° high"))
        }
        .frame(width: UIScreen.screenWidth/2)
    }
}


//#Preview {
//    DayForecastView()
//}
