//
//  Episode.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import Foundation

struct EpisodeResponse:Codable {
    
    let results:[Episode]
}
struct Episode: Codable, Identifiable {
    let id:Int
    let name: String
    let created:String
    let episode:String
}
