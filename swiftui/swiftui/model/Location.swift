//
//  Location.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import Foundation

struct LocationResponse:Codable {
    
    let results:[Location]
}
struct Location: Codable, Identifiable {
    let id:Int
    let name: String
    let created:String
    
}
