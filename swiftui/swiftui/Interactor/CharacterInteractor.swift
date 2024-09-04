//
//  CharacterInteractor.swift
//  swiftui
//
//  Created by Abdur Rahim on 03/09/24.
//

import Foundation
import Combine

protocol CharacterInteractorProtocol: AnyObject {
    func fetchData()
}

class CharacterInteractor: CharacterInteractorProtocol {
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkingServiceProtocol
    private let presenter: CharacterResponseViperPresenterProtocol
    func fetchData() {
        let urlString = "https://rickandmortyapi.com/api/character"
        networkService.fetchAnyForViper(strUrl: urlString)
            .sink(receiveCompletion: {
            [weak self]
            completion in
                //self?.view?.showLoader(false)
                switch completion {
                case .failure(let error):
                    self?.presenter.didFailWithError(error: error)
                case .finished:
                    break
                }
               
        }, receiveValue: { [weak self]
            (data :CharacterResponse) in
//            self?.view?.updateView(with: data)
            self?.presenter.didReceiveData(data: data)
        })
        .store(in: &cancellables)
    }
    
    
    
    init(networkService: NetworkingServiceProtocol, presenter: CharacterResponseViperPresenterProtocol ) {
        self.networkService = networkService
        self.presenter = presenter
    }
    
    func fetchData(from url: String, completion: @escaping (Result<CharacterResponse, NetworkError>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        networkService.fetchAnyForViper(strUrl: urlString)
            .sink(receiveCompletion: {
            [weak self]
            completion in
                //self?.view?.showLoader(false)
                switch completion {
                case .failure(let error):
                    self?.presenter.didFailWithError(error: error)
                case .finished:
                    break
                }
               
        }, receiveValue: { [weak self]
            (data :CharacterResponse) in
//            self?.view?.updateView(with: data)
            self?.presenter.didReceiveData(data: data)
        })
        .store(in: &cancellables)
    }
}
