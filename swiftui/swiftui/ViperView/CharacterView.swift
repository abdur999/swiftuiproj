//
//  CharacterView.swift
//  swiftui
//
//  Created by Abdur Rahim on 04/09/24.
//

import Foundation

//This prtocol added for Viper only
protocol CharacterViewTProtocol {
    func showData(data: CharacterResponse)
    func showerror(error: NetworkError)
}


class CharacterView:  ObservableObject,CharacterViewTProtocol {
    
    //Viper variable added
    @Published var data: CharacterResponse?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var interactor: CharacterInteractorProtocol?
    
    init() {
        let networkService = NetworkingService()
        let presenter = CharacterResponseViperPresenter(view: self)
        self.interactor = CharacterInteractor(networkService: networkService, presenter: presenter)
    }
    
    //Viper methods added
    func showData(data: CharacterResponse) {
        DispatchQueue.main.async {
            self.data = data
            self.isLoading = false
        }
    }
    
    func showerror(error: NetworkError) {
        switch error {
        case .decodingError:
                   self.errorMessage = "URL creation failed."
        case .invalidResponse:
                   self.errorMessage = "URL not found."
        case .invalidURL:
                   self.errorMessage = "JSON conversion failed."
        case .requestFailed(_):
                   self.errorMessage = "Response not found."
        case .unknownError:
            self.errorMessage = "Response not found."
        case .serverError(_):
            self.errorMessage = "Response not found."
            
        }
        self.isLoading = false
    }
    
    func fetchData() {
        self.isLoading = true
        interactor?.fetchData()
    }
    
}
