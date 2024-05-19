//
//  TitleView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 18/05/24.
//

import SwiftUI

struct TitleView: View {
    var title : String
    var imageName : String
    var body: some View {
        HStack {
            Label {
                Text(title.uppercased())
                    .font(.caption)
            } icon: {
                Image(systemName: imageName)
            }
            .foregroundColor(.white)
            
            Spacer() // Pushes the label to the left
        }
    }
}

#Preview {
    TitleView(title: "feels like", imageName: "thermometer.medium")
}
