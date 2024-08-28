//
//  EpisodeRow.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct EpisodeRow: View {
    let episode:Episode
    var body: some View {
        VStack {
            Text(episode.name)
            Text(episode.episode)
            Text(episode.created)
        }
    }
}

#Preview {
    EpisodeRow(episode: Episode(id: 1, name: "2", created: "43243", episode: "56767"))
}
