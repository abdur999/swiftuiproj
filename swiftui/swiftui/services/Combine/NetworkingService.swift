//
//  NetworkingService.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Error)
    case unknownError
}


@Observable
class NetworkingService {
    var characters:[Ccharacter] = []
    var locations:[Location] = []
    var episodes:[Episode] = []
    var subscription = Set<AnyCancellable>()
    
    
    
    //Networking Service using Genric retun type for get request, Any url
    func fetchAny<T:Decodable>(strUrl:String, responseType:T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: strUrl ) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                
                guard let httpResponse = result.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(NSError(domain: "", code: (result.response as? HTTPURLResponse)? .statusCode ?? 500, userInfo: nil))
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError {
                error in
                if let error = error as? DecodingError {
                    return NetworkError.decodingError
                } else if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
    
    //Networking Service using MVVM
    func fetchCharacterArray() -> AnyPublisher<CharacterResponse, NetworkError> {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                
                guard let httpResponse = result.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(NSError(domain: "", code: (result.response as? HTTPURLResponse)? .statusCode ?? 500, userInfo: nil))
                }
                return result.data
            }
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .mapError {
                error in
                if let error = error as? DecodingError {
                    return NetworkError.decodingError
                } else if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map{
                $0.data
            }
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                case .finished:
                    print("Data fetched")
                    
                }
            } receiveValue: { decodeData in
                self.characters = decodeData.results
            }
            .store(in: &subscription)
    }
    // First API call
    func fetchEpisodeData()  {
            let url = URL(string: "https://rickandmortyapi.com/api/episode")!
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: EpisodeResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Episode API calls were successful.")
                    case .failure(let error):
                        print("Episode API An error occurred: \(error)")
                    }
                } receiveValue: { [weak self] episodeResponse in
                    self?.episodes = episodeResponse.results
                }
                .store(in: &subscription)
        }
        
        // Location API call
        func fetchLocationData(){
            let url = URL(string: "https://rickandmortyapi.com/api/location")!
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: LocationResponse.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Location API calls were successful.")
                    case .failure(let error):
                        print("Location API An error occurred: \(error)")
                    }
                } receiveValue: { [weak self] locationResponse in
                    self?.locations = locationResponse.results
                }
                .store(in: &subscription)
        }
        
        // Function to chain the API calls
     /*   func fetchChainedData() {
            
            fetchEpisodeData().sink(receiveCompletion: { [weak self] eCompletion in
                switch eCompletion {
                case .finished:
                    print("Episode API calls were successful.")
                case .failure(let error):
                    print("Episode API An error occurred: \(error)")
                }

            }, receiveValue: { [weak self] episodeResponse in
                
                self?.fetchLocationData().sink {[weak self] lCompletion in
                    switch lCompletion {
                    case .finished:
                        print("Location API calls were successful.")
                    case .failure(let error):
                        print("Location API An error occurred: \(error)")
                    }
                } receiveValue: {[weak self] locationResponse in
                    self?.locations = locationResponse.results
                }
            })
                
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        print("Both API calls were successful.")
//                    case .failure(let error):
//                        print("An error occurred: \(error)")
//                    }
//                }, receiveValue: { secondResponse in
//                    locations = secondResponse.results
//                    print("Second API Response: \(secondResponse)")
//                })
                .store(in: &subscription)
        }
    */
}
