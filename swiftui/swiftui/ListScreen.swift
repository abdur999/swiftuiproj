//
//  ListScreen.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct ListScreen: View {
    var vm = NetworkingService()
    var body: some View {
//        VStack {
//            List(vm.characters) { character in
//             CharacterRow(character: character)
//            }
//        }
        TabBarView()
        .onAppear {
            
        }
    }
}

#Preview {
    ListScreen()
}
