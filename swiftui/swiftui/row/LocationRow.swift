//
//  LocationRow.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct LocationRow: View {
    let location:Location
    var body: some View {
        VStack {
            Text(location.name)
            Text(String(location.id))
            Text(location.created)
        }
    }
}
