//
//  HourForecastView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 27/04/24.
//

import SwiftUI
import WeatherKit

struct HourForecastView: View {
    var hourWeather : HourWeather
    
    var body: some View{
        VStack{
            Text(hourWeather.date.formatAbbreviatedHour())
                .foregroundColor(.white)
                .font(.headline)
            
            Image(systemName: ("\(hourWeather.symbolName).fill"))
                .symbolRenderingMode(.multicolor)
                .frame(width: 20, height: 20)
                .font(.headline)
            
            Text((hourWeather.temperature.formatted(.measurement(numberFormatStyle: .number.precision(.fractionLength(0))))).dropLast(1))
                .foregroundColor(.white)
                .font(.headline)
            
        }
        //.accessibilityElement(children: .combine)
        .padding(.horizontal, 7)
    }
}

extension Date{
    func formatAbbreviatedDay() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    func formatAbbreviatedHour() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}

//#Preview {
//    HourForecastView(hourWeather: )
//}
