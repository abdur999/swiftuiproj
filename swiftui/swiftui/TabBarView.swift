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
            ListTab(title: "Character", id: 10)
                .tabItem {
                    Label("Character", systemImage: "list.bullet")
                }
            ListTab(title: "Location", id: 20)
                .tabItem {
                    Label("Location", systemImage: "heart.fill")
                }
            ListTab(title: "Episode", id: 30)
                .tabItem {
                    Label("Episode", systemImage: "person.crop.circle.fill.badge.plus")
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

