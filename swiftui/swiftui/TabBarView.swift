//
//  TabBarView.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct TabBarView: View {
   
    var body: some View {
        TabView {
            ListTab(title: "List1", id: 10)
                .tabItem {
                    Label("Tab 1", systemImage: "list.bullet")
                }
            ListTab(title: "List2", id: 20)
                .tabItem {
                    Label("Tab 2", systemImage: "list.bullet")
                }
            ListTab(title: "List3", id: 30)
                .tabItem {
                    Label("Tab 2", systemImage: "list.bullet")
                }
        }
        .onAppear(){
            
        }
    }
}
struct ListTab:View {
    var vm = NetworkingService()
    let title:String
    let id:Int
    var body: some View {
        VStack {
            if(id==10) {
                List(vm.characters) { character in
                    CharacterRow(character: character)
                }
            }
            if id == 20 {
                List(vm.episodes) { episode in
                    EpisodeRow(episode: episode)
                }
            }
            if id == 30 {
                List(vm.locations) { location in
                    LocationRow(location: location)
                }
            }
            
        }
        .onAppear() {
            if(id == 10) {
                vm.fetchCharacters()
                
            }
            if(id == 20) {
                vm.fetchEpisodeData()
            }
            if(id == 30) {
                vm.fetchLocationData()
            }
        }
    }
}
#Preview {
    TabBarView()
}

