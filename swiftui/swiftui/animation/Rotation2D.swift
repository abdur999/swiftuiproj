//
//  Rotation.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct Rotation2D: View {
    @State private var rotationAngle: CGFloat = 0.0
    var body: some View {
        VStack(spacing: 50) {
            Button(action: {
                withAnimation(.linear(duration: 0.6)) {
                    rotationAngle = rotationAngle + 360
                }
            }, label: {
                Text("Rotate!")
            })
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
            )
            
            Image(systemName: "arrowshape.up")
                .font(.system(size: 50))
                .rotationEffect(Angle(degrees: rotationAngle))

        }
    }
}


#Preview {
    Rotation2D()
}
