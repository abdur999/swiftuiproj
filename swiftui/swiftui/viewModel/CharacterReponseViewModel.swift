//
//  CharacterReponseViewModel.swift
//  swiftui
//
//  Created by Abdur Rahim on 30/08/24.
//

import Foundation
import Combine

class CharacterReponseViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var data: CharacterResponse?
    @Published var errorMessage:String?
    private let networkService = NetworkingService()
    
    func loadDataGeneric() {
        networkService.fetchAny(strUrl: "https://rickandmortyapi.com/api/character", responseType: CharacterResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self]
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(error)
                }
            },
            receiveValue:{
                [weak self]
                    data in
                    self?.data = data
                
            })
            .store(in: &cancellable)
    }
    
    func loadData() {
        networkService.fetchCharacterArray()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.handleError(error)
                }
            },
            receiveValue:{
                [weak self]
                    data in
                    self?.data = data
                
            })
            .store(in: &cancellable)
    }
    private func handleError(_ error:NetworkError) {
        switch error {
            
        case .invalidURL:
            errorMessage = "The URL is invalid"
        case .invalidResponse:
            errorMessage = "Response is  incorrect format"
        case .decodingError:
            errorMessage = "Failed to parse json"
        case .serverError(let statusCode):
            errorMessage = "Server responded with status code \(statusCode)"
        case .unknownError:
            errorMessage = "An unknown error occured"
        }
    }
}
