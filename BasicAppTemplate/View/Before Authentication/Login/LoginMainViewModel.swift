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
        
        @Published var validations: [Bool] = Array(repeating: false, count: 2)
        
        func performLogin() async {
            DispatchQueue.main.async { self.loading = true }
            await Backend.shared.login(email: self.email, password: self.password) { result in
                switch result {
                case .success(_):
                    OpenURL.main.email = self.email
                    NavigationManager.shared.navigate(to: .confirmEmail(title: "Authenticate yourself", subheadline: "An email was sent to you", email: self.email, password: self.password, type: .login), path: .beforeAuth)
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
            DispatchQueue.main.async { self.loading = false }
        }
    }
    
}
