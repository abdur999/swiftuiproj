//
//  SplashView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    var body: some View {
        if isActive {
            NavigationStackView()
                .navigationBarBackButtonHidden(true)
        }
        else {
                Text("Splash Screen")
                    .font(.largeTitle)
                    .foregroundColor(colorScheme == .dark ? .red : .green)
                    .background(colorScheme == .dark ? .red : .green)
                    .padding()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                            withAnimation{
                                self.isActive = true
                            }
                        }
                    }
            
            .background(colorScheme == .dark ? .red :.green)
        }
    }
}

#Preview {
    SplashView()
}
