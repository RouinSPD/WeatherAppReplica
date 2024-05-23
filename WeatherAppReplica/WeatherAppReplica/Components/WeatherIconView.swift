//
//  WeatherIconView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 23/05/24.
//

import SwiftUI
import WeatherKit

struct WeatherIconView: View {
   // var dayWeather:  DayWeather
    var precipitationChance : Double
    var symbolName : String
    var body: some View {
        VStack(spacing: 0) {
            // if dayWeather.precipitationChance*100 >= 20 && !dayWeather.symbolName.contains("sun.max"){
            if symbolName.contains("sun.max"){
                Image(systemName: ("\(symbolName).fill"))
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .frame(width: UIScreen.screenWidth/16)
            }
            else if precipitationChance*100 >= 20  {
                if symbolName.contains(".drizzle"){
                    Image(systemName: ("\(symbolName).fill"))
                        .symbolRenderingMode(.multicolor)
                        .font(.title3)
                        .frame(width: UIScreen.screenWidth/16)
                }
                else  {
                    Image(systemName: ("\(symbolName).rain.fill"))
                        .symbolRenderingMode(.multicolor)
                        .font(.title3)
                        .frame(width: UIScreen.screenWidth/16)
                }
               
                //.accessibilityLabel(weather.accesibilityText)
                
                // Only show precipitation if it exists
                Text("\(Int(precipitationChance*100))%")
                    .font(.caption)
                    .foregroundStyle(.cyan)
                    .bold()
                //            }
            }
            else {
                Image(systemName: ("\(symbolName).fill"))
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                    .frame(width: UIScreen.screenWidth/16)
                //.accessibilityLabel(weather.accesibilityText)
            }
        }
    }
}

//#Preview {
//    WeatherIconView(dayWeather: <#DayWeather#>)
//}
