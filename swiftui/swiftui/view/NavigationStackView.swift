//
//  NavigationStackView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct NavigationStackView: View {
    @State private var navigationPath = NavigationPath()
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $navigationPath) {
                LoginView()
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        } else {
            // Less than ios version 16 swiftui navigationStack not supported
        }
    }
}

#Preview {
    NavigationStackView()
}
