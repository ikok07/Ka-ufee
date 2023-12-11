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
        
        @Published var email: String = ""
        @Published var password: String = ""
        
        func performLogin() async {
            
            await Backend.shared.login(email: self.email, password: self.password) { result in
                switch result {
                case .success(let response):
                    print(response.message)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
}
