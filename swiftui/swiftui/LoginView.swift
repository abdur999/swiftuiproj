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
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField(
                "Enter Login Id ..",
                text: $loginname
            )
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .padding()
            SecureField("Enter Password", text: $password)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .padding()
            Button("Login") {
                if loginname.count > 5 && password.count > 8 {
                    isAuthenticated = true
                } else {
                    showingAlert = true
                }
            }
            .border(.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .padding(20)
            HStack {
                
                NavigationLink {
//                    RegisterView()
                } label: {
                        Text("Register")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                   }
                Spacer()
                NavigationLink {
//                    ForgotPasswordView()
                } label: {
                        Text("Forgot Password")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                   }
                
            }
            .padding(10)
            Spacer()

        }
        .padding()
        
//        NavigationLink(destination: ListScreen(), isActive: $isAuthenticated) {
//            
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Warning"),
//                  message: Text("At least 5 character for loginid and password should be 8 character long"),
//                  primaryButton: .destructive(Text("Ok")) {
//                showingAlert = false
//            },
//            secondaryButton: .cancel({
//                showingAlert = false
//            })
//            )
//        }
    }
}

#Preview {
    LoginView()
}
