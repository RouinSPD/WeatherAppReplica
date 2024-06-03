//
//  UVIndexView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct UVIndexView: View {
    var uvIndexValue : Int
    var uvIndexDescription : String
    var body: some View {
        VStack(alignment: .leading){
            TitleView(title: "UV index", imageName: "sun.max.fill")
            Text("\(uvIndexValue)")
                .foregroundStyle(.white)
                .font(.title)
            Text(uvIndexDescription)
                .foregroundStyle(.white)
                .font(.title3)
            ColorBar(multiplier: uvIndexValue)
            Spacer()
           description
            
        }
        .frame(width: 140, height: 140)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        //.foregroundColor(.white)
    }
    
    var description : some View{
        VStack{
            if uvIndexValue < 3 {
                Text("You can safely enjoy being outside!")
                    .foregroundStyle(.white)
                    .font(.footnote)
                    .fontWeight(.light)
    
            }
            else if uvIndexValue >= 3 && uvIndexValue <= 7{
                Text("Seek shade during midday hours!")
                    .foregroundStyle(.white)
                    .font(.footnote)
                    .fontWeight(.light)
            }
            else if uvIndexValue >= 8{
                Text("Shirt, sunscreen and hat are a must!")
                    .foregroundStyle(.white)
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    UVIndexView(uvIndexValue: 5, uvIndexDescription: "Moderate")
}
