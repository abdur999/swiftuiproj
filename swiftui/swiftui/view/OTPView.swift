//
//  OTPView.swift
//  swiftui
//
//  Created by Abdur Rahim on 28/08/24.
//

import SwiftUI

struct OTPView: View {
    @State private var otp: [String] = ["", "", "", ""]
    @FocusState private var currentIndex: Int?
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<4) { index in
                TextField("", text: Binding(
                    get: { self.otp[index] },
                    set: { newValue in
                        self.otp[index] = newValue
                        if newValue.count == 1 {
                            // Move to next field if input is valid
                            if index < 3 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.currentIndex = index + 1
                                    self.becomeFirstResponder(at: index + 1)
                                }
                            }
                        } else if newValue.isEmpty {
                            // Move to previous field if input is deleted
                            if index > 0 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.currentIndex = index - 1
                                    self.becomeFirstResponder(at: index - 1)
                                }
                            }
                        }
                    }
                ))
                .frame(width: 50, height: 50)
                .multilineTextAlignment(.center)
                .border(Color.gray, width: 1)
                .keyboardType(.numberPad)
                .onTapGesture {
                    self.currentIndex = index
                }
                .focused($currentIndex, equals: index)
            }
        }
        .padding()
    }
    
    private func becomeFirstResponder(at index: Int) {
        DispatchQueue.main.async {
            let nextResponder = UIApplication.shared.connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first?.rootViewController?.view
                .viewWithTag(index + 1)
            nextResponder?.becomeFirstResponder()
        }
    }
}

#Preview {
    OTPView()
}
