//
//  LoginView.swift
//  swiftui
//
//  Created by Abdur Rahim on 27/08/24.
//

import SwiftUI

struct LoginView: View {
    @State private var loginname:String = ""
    @State private var password:String = ""
    @State private var showingAlert = false
    @State private var isAuthenticated = false
    
    @State var degreesRotating = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .rotationEffect(.degrees(degreesRotating))
            
            
            TextField(
                "",
                text: $loginname
            )
            .placeholder(when: loginname.isEmpty) {
                    Text("Enter Login Id ..").foregroundColor(.black)
            } //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter if we put then we have two text that will not good for our dewsign
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .font(.title3)
            .padding()
            .background(
            RoundedRectangle(cornerRadius : 10)
                .strokeBorder(Color.gray, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius : 10).fill(Color.white))
            )
            SecureField("", text: $password)
                .placeholder(when: password.isEmpty) {
                        Text("Enter Password").foregroundColor(.black)
                } //Textfield when empty then we can create a placeholder and when we implement this we don't need to put text in first parameter
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .font(.title3)
                .padding() // padding inside the textfield
                .background( // set background view
                RoundedRectangle(cornerRadius : 10) // shape as rounded rectangle
                    .strokeBorder(Color.gray, lineWidth: 1) //stroke color for textview
                    .background(
                        RoundedRectangle(cornerRadius : 10)
                            .fill(Color.white))
                )
            Button("Login") {
                if loginname.count > 5 && password.count > 8 {
                    isAuthenticated = true
                } else {
                    showingAlert = true
                }
            }

            .font(.headline) // change font size and weight
            .foregroundColor(.white) //Text Color
            .padding(20) // padding inside the button
            .background(Color.green) //background color
            .cornerRadius(10)  //rounded corners
            .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
            HStack {
                
                NavigationLink {
                    RegisterView()
                } label: {
                        Text("Register")
                        .font(.headline) // change font size and weight
                        .foregroundColor(.white) //Text Color
                        .padding(20) // padding inside the button
                        .background(Color.green) //background color
                        .cornerRadius(10)  //rounded corners
                        .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
                   }
                Spacer()
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                        Text("Forgot Password")
                        .font(.headline) // change font size and weight
                        .foregroundColor(.white) //Text Color
                        .padding(20) // padding inside the button
                        .background(Color.green) //background color
                        .cornerRadius(10)  //rounded corners
                        .shadow(color: .gray, radius: 5, x: 0, y: 2) //shadow effect
                   }
                
            }
            .padding(10)
            Spacer()

        }
        .padding()
        
        NavigationLink(destination: ListScreen(), isActive: $isAuthenticated) {
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Warning"),
                  message: Text("At least 5 character for loginid and password should be 8 character long"),
                  primaryButton: .destructive(Text("Ok")) {
                showingAlert = false
            },
            secondaryButton: .cancel({
                showingAlert = false
            })
            )
        }
        .onAppear {
                      withAnimation(.linear(duration: 1)
                          .speed(0.2).repeatForever(autoreverses: false)) {
                              degreesRotating = 360.0
                          }
                  }
    }
        
}

#Preview {
    LoginView()
}
