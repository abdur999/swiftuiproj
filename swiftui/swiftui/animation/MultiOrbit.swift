//
//  MultiOrbit.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI


struct MultiOrbit2D: View {

    private let innerRadius: CGFloat = 100
    private let outerRadius: CGFloat = 150

    @State private var innerAngle: CGFloat = 0.0
    @State private var outerAngle: CGFloat = 0.0

    
    var body: some View {
        VStack(spacing: 50) {
            Button(action: {
                innerAngle = innerAngle + 360
                outerAngle = outerAngle - 360
            }, label: {
                Text("Rotate!")
            })
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.8))
            )
            
            
            ZStack {
                
                // inner orbit
                ZStack {
                    // orbit circle
                    if #available(iOS 17.0, *) {
                        Circle()
                            .fill(Color.clear)
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 2))
                            .frame(width: innerRadius * 2)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    // view to rotate
                    Icon(systemImageName: "cat.fill")
                        .offset(y: -innerRadius)

                    Icon(systemImageName: "bird.fill")
                        .offset(y: -innerRadius)
                        .rotationEffect(Angle(degrees: 120))

                    Icon(systemImageName: "fish.fill")
                        .offset(y: -innerRadius)
                        .rotationEffect(Angle(degrees: 240))
                    
                }
                .rotationEffect(Angle(degrees: innerAngle))
                .animation(.linear(duration: 2.4).repeatForever(autoreverses: false), value: innerAngle)

                // outer orbit
                ZStack {
                    // orbit circle
                    if #available(iOS 17.0, *) {
                        Circle()
                            .fill(Color.clear)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 2))
                            .frame(width: outerRadius * 2)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    // view to rotate
                    Icon(systemImageName: "hare.fill")
                        .offset(y: -outerRadius)
                        .rotationEffect(Angle(degrees: -30))


                    Icon(systemImageName: "tortoise.fill")
                        .offset(y: -outerRadius)
                        .rotationEffect(Angle(degrees: 90))

                    Icon(systemImageName: "dog.fill")
                        .offset(y: -outerRadius)
                        .rotationEffect(Angle(degrees: 210))
                }
                .rotationEffect(Angle(degrees: outerAngle))
                .animation(.linear(duration: 3.0).repeatForever(autoreverses: false), value: outerAngle)

                
                // center
                Icon(systemImageName: "checkmark")

            }
            .padding(.all, 10)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black)

    }
}

fileprivate struct Icon: View {
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(Color.black)
            .padding(.all, 12)
            .background(
                Circle()
                    .fill(Color.white.opacity(0.8))
            )
    }
}

#Preview {
    MultiOrbit2D()
}
