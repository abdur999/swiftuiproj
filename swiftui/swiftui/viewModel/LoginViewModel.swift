//
//  LoginViewModel.swift
//  swiftui
//
//  Created by Abdur Rahim on 29/08/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var userEmail:String = ""
    @Published var password:String = ""
    @Published var isLoggedIn:Bool = false
    @Published var errorMessage:String? = nil
    
    var subscription = Set<AnyCancellable>()
    
    func login() {
        if userEmail.isEmpty || password.isEmpty{
            errorMessage = "Email or Password cannot be empty"
            return
        }
        if  userEmail.isValidEmail == false  {
            errorMessage = "Please enter a valid email"
            return
        }
        if password.count < 6 {
            errorMessage = "Please enter a valid password, password cannot be less than 6 character"
            return
        }
        
    }
}
