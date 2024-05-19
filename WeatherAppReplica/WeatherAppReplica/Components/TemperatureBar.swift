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
    var minScaleTemp : Double
    var maxScaleTemp : Double
    var body: some View {
        
            let totalScale = lowTemperature - highTemperature
            let scaleRange = CGFloat(totalScale)
            //let lowerBoundOffset = CGFloat(lowTemperature - minScaleTemp) / scaleRange * geometry.size.width
           // let upperBoundOffset = CGFloat(highTemperature - minScaleTemp) / scaleRange * geometry.size.width

            ZStack(alignment: .leading) {
                // Bottom rectangle (background)
                Rectangle()
                    .frame(width: UIScreen.screenWidth*0.3, height: 6)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                    .cornerRadius(20)
                
                // Gradient for the temperature range
                Rectangle()
                    .frame(width: UIScreen.screenWidth*0.2, height: 6)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
                
                
//
//                    .frame(width: upperBoundOffset - lowerBoundOffset, height: 8)
//                    .offset(x: lowerBoundOffset, y: 0)
//                    .cornerRadius(20)
            }
        }
    }


struct TemperatureBarView : View {
    var body: some View {
        Spacer()
        TemperatureBar(lowTemperature: 14, highTemperature: 19, minScaleTemp: 10, maxScaleTemp: 26)
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
