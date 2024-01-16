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
        
        var validations: [Bool] = Array(repeating: false, count: 4)
        
        func signUp() async {
            isLoading = true
            await Backend.shared.signUp(
                name: self.name,
                email: self.email,
                password: self.password,
                confirmPassword: self.confirmPassword,
                deviceToken: NotificationManager.shared.deviceToken
            ) { result in
                switch result {
                case .success(let response):
                    OpenURL.main.email = self.email
                    OpenURL.main.appSecurityTokenId = response.appSecurityTokenId
                    NavigationManager.shared.navigate(to: .confirmEmail(title: "Confirm your email", subheadline: "An email was sent to you", email: self.email, type: .signup), path: .beforeAuth)
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
            isLoading = false
        }
        
    }
    
}

