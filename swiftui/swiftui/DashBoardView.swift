//
//  DashBoardView.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI


struct DashBoardView: View {
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
    DashBoardView()
}
