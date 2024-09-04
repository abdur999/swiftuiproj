//
//  ForgotPasswordView.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var isEmailVerified:Bool = false
    @State private var isOtpSend:Bool = false
    @State private var isValidEmail:Bool = false
    @State private var message:String = ""
    @State private var isNotValidEmail:Bool = false
    var body: some View {
        VStack {
            CustomNavigationBar(title: "Back to Login", onButtonTapped: {
                dismiss()
            })
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top,40)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            TextField("", text: $email)
                .placeholder(when: email.isEmpty) {
                        Text("Enter your email address").foregroundColor(colorScheme == .dark ? .black : .white)
                } //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
        //            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .font(.title3)
                .padding()
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .background(
                RoundedRectangle(cornerRadius : 10)
                    .strokeBorder(Color.gray, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius : 10).fill(colorScheme == .dark ? .white : .black))
                )
            
            Button(action: {
                
                if email.isEmpty {
                    message = "Please enter a email id"
                    isNotValidEmail = true
                }
                
                else if email.isValidEmail == false{
                    message = "Please enter a valid email id"
                    isNotValidEmail = true
                }
                else {
                    isOtpSend = true
                    isNotValidEmail = false
                }
                
            }) {
                if isOtpSend {
                    Text("Resend Otp")
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(colorScheme == .dark ? .red : .green)
                        .cornerRadius(15.0)
                }
                else {
                    Text("Send Otp")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(colorScheme == .dark ? .green : .red)
                        .cornerRadius(15.0)
                }
            }
            if isOtpSend  {
                OTPView()
                Button(action: {
                    // reset to false as this is the initial state
                    
                    if isOtpSend {
                        
                    }
                }) {
                    
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(colorScheme == .dark ? .green : .red)
                        .cornerRadius(15.0)
                    
                }
                
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        
            .alert(isPresented: $isNotValidEmail) {
                Alert(title: Text("Warning"),
                      message: Text(message),
                      primaryButton: .destructive(Text("Ok")) {
                    isNotValidEmail = false
                },
                      secondaryButton: .cancel({
                    isNotValidEmail = false
                })
                )
            }
        
            
        .navigationTitle("Forgot Password")
    }
        
}

#Preview {
    ForgotPasswordView()
}
