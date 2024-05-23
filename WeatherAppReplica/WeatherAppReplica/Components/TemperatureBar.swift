//
//  TemperatureBar.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 28/04/24.
//

import SwiftUI

struct TemperatureBar: View {
    var lowTemperature : Double
    var highTemperature : Double
    var currentTemperature : Double
    var minScaleTemp : Double
    var maxScaleTemp : Double
    var body: some View {
        
        let totalScale = maxScaleTemp - minScaleTemp
        let rangeDayTemp = highTemperature - lowTemperature
        let width = UIScreen.screenWidth*0.3
        
        ZStack(alignment: .leading) {
            // Bottom rectangle (background)
            Rectangle()
                .frame(width: UIScreen.screenWidth*0.3, height: 5)
                .opacity(0.3)
                .foregroundColor(Color(UIColor.systemTeal))
                .cornerRadius(20)
            
            // Gradient for the temperature range
            Rectangle()
                .frame(width: width*(rangeDayTemp/totalScale), height: 5)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ Color.green, Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .offset(CGSize(width: ((UIScreen.screenWidth*0.3))*(lowTemperature-minScaleTemp)/totalScale, height: 0))
                         .cornerRadius(20)
        }
    }
}


struct TemperatureBarView : View {
    var body: some View {
        Spacer()
        TemperatureBar(lowTemperature: 14, highTemperature: 26, currentTemperature: 17, minScaleTemp: 14, maxScaleTemp: 28)
        Spacer()
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

#Preview {
    TemperatureBarView()
}
