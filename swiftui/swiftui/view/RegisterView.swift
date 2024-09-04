//
//  RegisterView.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) private var presentationMode:Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    @State private var loginname:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var confirmPassword:String = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            
            CustomNavigationBar(title: "Back to Login", onButtonTapped: {
                dismiss()
            })
            
            Text("Registration")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/) // change font size and weight
                .foregroundColor(colorScheme == .dark ? .white : .black) //Text Color
                .padding(20) // padding inside the button
                .background(colorScheme == .dark ? .red : .green) //background color
                .cornerRadius(10)  //rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
            TextField(
                "",
                text: $loginname
            )
            .placeholder(when: loginname.isEmpty) {
                Text("Enter Login Id ..").foregroundColor(colorScheme == .dark ? .black : .white)
            } //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
            //            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .font(.title3)
            .padding()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .background(
                RoundedRectangle(cornerRadius : 10)
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius : 10).fill(colorScheme == .dark ? .white : .black))
            )
            TextField(
                "",
                text: $email
            )
            .placeholder(when: email.isEmpty) {
                Text("Email").foregroundColor(colorScheme == .dark ? .black : .white)
            } //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
            .font(.title3)
            .padding()
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .background(
                RoundedRectangle(cornerRadius : 10)
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius : 10).fill(colorScheme == .dark ? .white : .black))
            )
            SecureField("", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text("Enter your Password").foregroundColor(colorScheme == .dark ? .black : .white)
                }
            //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
                .font(.title3)
                .padding()
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .background(
                    RoundedRectangle(cornerRadius : 10)
                        .strokeBorder(Color.gray, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius : 10).fill(colorScheme == .dark ? .white : .black))
                )
            SecureField("", text: $confirmPassword)
                .placeholder(when: password.isEmpty) {
                    Text("Reenter your Password").foregroundColor(colorScheme == .dark ? .black : .white)
                }
            //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
                .font(.title3)
                .padding()
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .background(
                    RoundedRectangle(cornerRadius : 10)
                        .strokeBorder(Color.gray, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius : 10).fill(colorScheme == .dark ? .white : .black))
                )
            Button("Register") {
                if loginname.isEmpty  {
                    alertMessage = "Login Id cannot be empty."
                }
                else if loginname.count < 5  {
                    alertMessage = "Login Id cannot be less than 5 character long."
                }
                else if email.isEmpty {
                    alertMessage = "Email cannot be empty."
                }
                else if email.isValidEmail == false {
                    alertMessage = "Please enter a valid email id"
                }
                else if password.isEmpty  {
                    alertMessage = "Password cannot be empty."
                }
                else if password.isEmpty  {
                    alertMessage = "Confirm Password cannot be empty."
                }
                else if (password == confirmPassword) == false {
                    alertMessage = "Password and confirm Password must be same."
                    showingAlert = true
                    
                }
            }
            .font(.headline) // change font size and weight
            .foregroundColor(colorScheme == .dark ? .white : .black) //Text Color
            .padding(20) // padding inside the button
            .background(colorScheme == .dark ? .red : .green) //background color
            .cornerRadius(10)  //rounded corners
            .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
            
            HStack {
                Button("Login") {
                    
                }
                .font(.headline) // change font size and weight
                .foregroundColor(colorScheme == .dark ? .white : .black) //Text Color
                .padding(20) // padding inside the button
                .background(colorScheme == .dark ? .red : .green) //background color
                .cornerRadius(10)  //rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
                Spacer()
                Button("Forgot Password") {
                    
                }
                .font(.headline) // change font size and weight
                .foregroundColor(colorScheme == .dark ? .white : .black) //Text Color
                .padding(20) // padding inside the button
                .background(colorScheme == .dark ? .red : .green) //background color
                .cornerRadius(10)  //rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
            }
            
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    RegisterView()
}
