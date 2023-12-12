//
//  SignUpMainViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI
import Observation
import iOS_Backend_SDK

extension SignUpMainView {
    
    @Observable final class ViewModel {
        
        var isLoading: Bool = false
        
        var name: String = ""
        var email: String = ""
        var password: String = ""
        var confirmPassword: String = ""
        
        func signUp() async {
            isLoading = true
            await Backend.shared.signUp(name: self.name, email: self.email, password: self.password, confirmPassword: self.confirmPassword) { result in
                switch result {
                case .success(_):
                    Navigator.main.navigate(to: .confirmEmail(title: "Confirm your email", subheadline: "An email was sent to you"), path: .beforeAuth)
                case .failure(let error):
                    Components.shared.showMessage(type: .error, text: error.localizedDescription)
                }
            }
            isLoading = false
        }
        
    }
    
}

