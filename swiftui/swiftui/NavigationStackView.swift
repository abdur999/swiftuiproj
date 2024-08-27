//
//  NavigationStackView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct NavigationStackView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                LoginView()
            }
        } else {
            // Less than ios version 16 swiftui navigationStack not supported
        }
    }
}

#Preview {
    NavigationStackView()
}
