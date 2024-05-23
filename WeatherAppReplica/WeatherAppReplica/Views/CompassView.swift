//
//  CompassView.swift
//  WeatherAppReplica
//
//  Created by Pedro Daniel Rouin Salazar on 21/05/24.
//

import SwiftUI

struct MyShape : Shape {
    var sections : Int
    var lineLengthPercentage: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let radius = rect.width / 2.5
        let degreeSeparation : Double = 360.0 / Double(sections)
        var path = Path()
        for index in 0..<Int(360.0/degreeSeparation) {
            let degrees = Double(index) * degreeSeparation
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let innerX = center.x + (radius - rect.size.width * lineLengthPercentage / 2) * CGFloat(cos(degrees / 360 * Double.pi * 2))
            let innerY = center.y + (radius - rect.size.width * lineLengthPercentage / 2) * CGFloat(sin(degrees / 360 * Double.pi * 2))
            let outerX = center.x + radius * CGFloat(cos(degrees / 360 * Double.pi * 2))
            let outerY = center.y + radius * CGFloat(sin(degrees / 360 * Double.pi * 2))
            path.move(to: CGPoint(x: innerX, y: innerY))
            path.addLine(to: CGPoint(x: outerX, y: outerY))
        }
        return path
    }
}

struct Triangle : Shape{
    func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            return path
        }
}
struct CompassView: View {
    // Angle in degrees where 0° is North, 90° is East, etc.
    var direction: String
    
    var body: some View {
        ZStack{
            Color(.gray.opacity(0.4))
            MyShape(sections: 180, lineLengthPercentage: 0.1)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
            MyShape(sections: 12, lineLengthPercentage: 0.1)
                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
            MyShape(sections: 4, lineLengthPercentage: 0.1)
                .stroke(Color.gray.opacity(0.8), lineWidth: 3)
            
            GeometryReader { geometry in
                let centerX = geometry.size.width / 2
                let centerY = geometry.size.height / 2
                let offset: CGFloat = 115
                
                Text("N")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.opacity(0.5))
                    .position(x: centerX, y: centerY - offset)
                Text("S")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.opacity(0.5))
                    .position(x: centerX, y: centerY + offset)
                Text("W")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.opacity(0.5))
                    .position(x: centerX - offset, y: centerY)
                Text("E")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.opacity(0.5))
                    .position(x: centerX + offset, y: centerY)
                
            }
            
                Circle()
                    .fill(.white.opacity(0.02))
                    .foregroundColor(.gray)
                    .frame(width: 150, height: 150)
                
                Text(direction)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.opacity(0.8))
                
           
        }
//        .frame(width: 140, height: 140)
//        .padding()
//        .background(Color.gray.opacity(0.4))
//        .cornerRadius(20)
//        .foregroundColor(.white)
    }
    
    //        ZStack {
    //            // Compass circle
    //
    //            VStack {
    //                        GeometryReader { geo in
    //                            Circle()
    //                                .stroke(Color.red, style: StrokeStyle(lineWidth: geo.size.width/18, lineCap: .butt, dash: [4, 20]))
    //                        .padding(geo.size.width/50)
    //                            }
    //                    }.padding()
    //
    //            Circle()
    //                //.fill(.white)
    //                .stroke(lineWidth: 5)
    //                .foregroundColor(.gray)
    //                .frame(width: 200, height: 200)
    //
    //
    //            // Cardinal directions
    //            VStack {
    //                Text("N")
    //                    .font(.headline)
    //                    .padding(.bottom, 150)
    //                Spacer()
    //                Text("S")
    //                    .font(.headline)
    //                    .padding(.top, 150)
    //            }
    //
    //            HStack {
    //                Text("W")
    //                    .font(.headline)
    //                    .padding(.trailing, 150)
    //                Spacer()
    //                Text("E")
    //                    .font(.headline)
    //                    .padding(.leading, 150)
    //            }
    //
    //            // Dynamic arrow
    ////            ArrowShape()
    ////                .fill(Color.white)
    ////                .frame(width: 10, height: 100)
    ////                .rotationEffect(Angle(degrees: direction))
    ////                .offset(y: -50)
    ////                .offset(x: 0)
    //        }
    //        .frame(width: 300, height: 300) // Adjust the frame size as needed
    //        .background(Color.blue.opacity(0.2)) // Add a background color if needed
    //    }
}

#Preview {
    CompassView(direction: "WSW")
}
