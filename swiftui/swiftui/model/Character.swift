//
//  Character.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import Foundation

struct CharacterResponse:Codable {
    
    let results:[Ccharacter]
}

struct Ccharacter: Codable, Identifiable {
    let id:Int
    let name: String
    let image:URL
    
}

//When we need custom keys to create 
extension CharacterResponse {
    enum CodingKeys: String, CodingKey {
        case results = "results"
        
    }
}

