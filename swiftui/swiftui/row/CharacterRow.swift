//
//  CharacterRow.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct CharacterRow: View {
    var character: Ccharacter
    var body: some View {
        HStack {
            AsyncImage(url:character.image) { image in
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25)), style: FillStyle())
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
        }
    }
}
