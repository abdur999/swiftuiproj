//
//  CharacterResponseViperPresenter.swift
//  swiftui
//
//  Created by Abdur Rahim on 03/09/24.
//

import Foundation
import Combine
//Hole coded added for support Viper
protocol CharacterResponseViperPresenterProtocol: AnyObject {
    func didReceiveData(data:CharacterResponse)
    func didFailWithError(error:NetworkError)
}

class CharacterResponseViperPresenter:CharacterResponseViperPresenterProtocol {
    private let view: CharacterView
    
    init(view: CharacterView) {
        self.view = view
    }
    func didReceiveData(data: CharacterResponse) {
        view.showData(data: data)
    }
    
    func didFailWithError(error: NetworkError) {
        view.showerror(error: error)
    }
}
