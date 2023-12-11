//
//  LoginMainViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI
import iOS_Backend_SDK

extension LoginMainView {
    
    final class ViewModel: ObservableObject {
        
        @Published var loading: Bool = false
        @Published var email: String = ""
        @Published var password: String = ""
        
        func performLogin() async {
            DispatchQueue.main.async { self.loading = true }
            await Backend.shared.login(email: self.email, password: self.password) { result in
                switch result {
                case .success(_):
                    Navigator.main.navigate(to: .confirmEmail(title: "Confirm your email", subheadline: "An email was sent to you"), path: .beforeAuth)
                case .failure(let error):
                    Components.shared.showMessage(type: .error, text: error.localizedDescription)
                }
            }
            DispatchQueue.main.async { self.loading = false }
        }
    }
    
}
