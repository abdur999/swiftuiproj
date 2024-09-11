//
//  ApiCall.swift
//  swiftui
//
//  Created by Abdur Rahim on 05/09/24.
//

import Foundation
import Combine

struct ApiCall {
    
    init() {
        
    }
    func callurl() {
        var cancellables = Set<AnyCancellable>()
        guard let url = URL(string: "https://rickandmortyapi.com/api/character1") else {
          return
        }
        let networkApiCall = NetworkingService()
        networkApiCall.urlCall(type:CharacterResponse.self ,url: url, retryCount: 10, delay: 3)
            .sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                   print("Data fetch complted successfully")
                case .failure(let error):
                    print("Data fetch complted wit Failure")
                }
                
            }
            , receiveValue: {
                       data in
                print("Received data \(data)")
            })
            .store(in: &cancellables)
    }
    
}
