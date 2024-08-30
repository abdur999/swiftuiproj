//
//  CustomNavigationBar.swift
//  swiftui
//
//  Created by Abdur Rahim on 29/08/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    var onButtonTapped:() -> Void
    var body: some View {
        HStack {
            Button(action: onButtonTapped) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
            }
            .padding()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            
            
            .background(Color.blue)
            .shadow(radius: 2)
        }
        .background(Color.blue)
        .shadow(radius: 2)
        .edgesIgnoringSafeArea(.top)
        Spacer()
    }
}

#Preview {
    CustomNavigationBar(title: "my back", onButtonTapped: {
    })
//    CustomNavigationBar()
}
