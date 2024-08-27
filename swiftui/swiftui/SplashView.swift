//
//  SplashView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            NavigationStackView()
        }
        else {
                Text("Splash Screen")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(.green)
                    .padding()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                            withAnimation{
                                self.isActive = true
                            }
                        }
                    }
            
            .background(.green)
        }
    }
}

#Preview {
    SplashView()
}
