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
                        
                        // Usage
                        let steak = Dish(name: "Steak", price: 2.30)
                        let chips = Dish(name: "Ships", price: 1.20)
                        let coffee = Dish(name: "Coffee", price: 0.80)
                        let builder = OrderBuilder()
                        builder.reset()
                        builder .setMainCourse(steak)
                        builder.setGarnish(chips)
                        builder .setDrink(coffee)
                        let order = builder.getResult()
                        order?.price
                        // Result:
                        // 4.30
                        
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
