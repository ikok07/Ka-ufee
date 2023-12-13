//
//  NavigationDestination.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

enum NavigationDestination: Hashable {
    
    // MARK: - Before Authentication
    case login
    case signUp
    case forgotPassword
    case forgotPasswordEmailConfirmed(token: String)
    case forgotPasswordSuccessfullyChanged
    case confirmEmail(title: String, subheadline: String)
    case confirmEmailSuccess
    
    // MARK: - Main Application
    case tabViewManager
    
    func getView() -> some View {
        switch self {
        case .login:
            return AnyView(LoginMainView())
            
        case .signUp:
            return AnyView(SignUpMainView())
            
        case .forgotPassword:
            return AnyView(ForgotPasswordEmailView())
            
        case .forgotPasswordEmailConfirmed(let token):
            return AnyView(ForgotPasswordMainView(token: token))
            
        case .forgotPasswordSuccessfullyChanged:
            return AnyView(ForgotPasswordSuccessfullyChangedView())
            
        case .confirmEmail(let title, let subheadline):
            return AnyView(EmailConfirmationView(title: title, subheadline: subheadline))
            
        case .confirmEmailSuccess:
            return AnyView(EmailConfirmationCompleteView())
            
        case .tabViewManager:
            return AnyView(TabViewManager())
        }
    }
    
}
