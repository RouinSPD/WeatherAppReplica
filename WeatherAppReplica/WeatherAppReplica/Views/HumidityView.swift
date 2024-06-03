//
//  HumidityView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct HumidityView: View {
    var humidity: Int
    var dewPoint : Int
    var body: some View {
        VStack(alignment: .leading){
            TitleView(title: "Humidity", imageName: "humidity.fill")
            Text("\(humidity)%")
                .foregroundStyle(.white)
                .font(.largeTitle)
            Spacer()
           Text("The dew point is \(dewPoint)° right now.")
                .foregroundStyle(.white)
                .font(.footnote)
                .fontWeight(.light)
        }
        .frame(width: 140, height: 140)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        //.foregroundColor(.white)
    }
}

#Preview {
    HumidityView(humidity: 58, dewPoint: 14)
}
