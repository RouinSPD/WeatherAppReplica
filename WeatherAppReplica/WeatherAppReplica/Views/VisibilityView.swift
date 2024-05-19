//
//  VisibilityView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct VisibilityView: View {
    var visibility : Int
    var body: some View {
        VStack(alignment: .leading){
            TitleView(title: "Visibility", imageName: "eye.fill")
            Text("\(visibility) km")
                .font(.largeTitle)
            Spacer()
           Text("Clear view.")
                .font(.footnote)
                .fontWeight(.light)
        }
        .frame(width: 140, height: 140)
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(20)
        .foregroundColor(.white)
    }
}

#Preview {
    VisibilityView(visibility: 12)
}
