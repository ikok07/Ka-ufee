//
//  LoginMainViewModel.swift
//  Kaufee
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
        
        @Published var validations: [Bool] = Array(repeating: false, count: 2)
        
        func performLogin() async {
            DispatchQueue.main.async { self.loading = true }
            await Backend.shared.login(email: self.email, password: self.password) { result in
                switch result {
                case .success(let response):
                    OpenURL.main.email = self.email
                    OpenURL.main.appSecurityTokenId = response.appSecurityTokenId
                    NavigationManager.shared.navigate(to: .confirmEmail(title: "Authenticate yourself", subheadline: "An email was sent to you", email: self.email, password: self.password, type: .login), path: .beforeAuth)
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
            DispatchQueue.main.async { self.loading = false }
        }
        
        func resendConfirmEmail() async {
            await Backend.shared.resendEmail(email: self.email) { result in
                switch result {
                case .success(let response):
                    OpenURL.main.email = self.email
                    OpenURL.main.appSecurityTokenId = response.appSecurityTokenId
                    UXComponents.shared.showMsg(type: .success, text: "We've sent you a new confirmation email")
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
        }
    }
    
}
