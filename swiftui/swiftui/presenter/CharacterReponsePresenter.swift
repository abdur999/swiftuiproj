//
//  CharacterReponsePresenter.swift
//  swiftui
//
//  Created by Abdur Rahim on 30/08/24.
//

import Foundation
import Combine

protocol CharacterViewProtocol {
    func updateView(with data: CharacterResponse)
    func showError(_ message: String)
    func showLoader(_ show: Bool)
}
class CharacterPresenterViewModel:ObservableObject {
    @Published var data: CharacterResponse?
    let presenter: CharacterReponsePresenter
    init() {
        self.presenter = CharacterReponsePresenter(networkService: NetworkingService())
    }
}

protocol CharacterReponsePresenterProtocol:AnyObject {
    func fetchData()
    func attachView(_ view: CharacterViewProtocol)
//    func fetchAnyForPresenter<T:Decodable>(strUrl:String) -> AnyPublisher<T, NetworkError>
}
class CharacterReponsePresenter:CharacterReponsePresenterProtocol {
//    func attachView(_ view: any CharacterReponsePresenterProtocol) {
//        
//    }
    
    private let networkService: NetworkingService
    private var view: CharacterViewProtocol?
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkingService) {
        self.networkService = networkService
    }
    
    func attachView(_ view: any CharacterViewProtocol) {
        self.view = view
    }
    
    func fetchData() {
        view?.showLoader(true)
        let urlString = "https://rickandmortyapi.com/api/character"
        
        networkService.fetchAnyForPresenter(strUrl: urlString)
            .sink(receiveCompletion: {
                [weak self]
                completion in
                self?.view?.showLoader(false)
            }, receiveValue: { [weak self]
                (data :CharacterResponse) in
                self?.view?.updateView(with: data)
            })
            .store(in: &cancellables)
    }
    
}
