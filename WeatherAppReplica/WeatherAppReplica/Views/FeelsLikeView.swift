//
//  FeelsLikeView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct FeelsLikeView: View {
    var feelsLikeDescription : Double
    var currentTemperature : Double
//    @StateObject private  var weatherViewModel = WeatherViewModel()
    var body: some View {
        VStack(alignment: .leading){
            TitleView(title: "feels like", imageName: "thermometer.medium")
            Text("\(Int(feelsLikeDescription))°")
                .font(.largeTitle)
            Spacer()
            description
        }
        .frame(width: 140, height: 140)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        .foregroundColor(.white)
    }
  
    var description : some View{
        VStack{
            if feelsLikeDescription == currentTemperature{
                Text("Similar to the actual temperature.")
                    .font(.footnote)
                    .fontWeight(.light)
            }
            else if feelsLikeDescription > currentTemperature{
                Text("Feels hotter than the actual temperature.")
                    .font(.footnote)
                    .fontWeight(.light)
            }
            else if feelsLikeDescription < currentTemperature{
                Text("Feels colder than the actual temperature.")
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    FeelsLikeView(feelsLikeDescription: 22, currentTemperature: 24)
}
