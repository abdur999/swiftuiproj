//
//  ContentView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            
            .padding()
            .background(Color(.green))
        }
        
    
    
}

#Preview {
    ContentView()
}
