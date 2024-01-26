//
//  NavigationDestination.swift
//  Kaufee
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
    case confirmEmail(title: String, subheadline: String, email: String, password: String = "", type: EmailConfirmType)
    case confirmEmailSuccess
    
    // MARK: - Main Application
    case tabViewManager
    case profileSetttings
    case changePasswordSettings
    case notificationSettings
    
    func getView() -> some View {
        switch self {
            
        // MARK: - Before Auth
            
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
            
        case .confirmEmail(let title, let subheadline, let email, let password, let type):
            return AnyView(EmailConfirmationView(title: title, subheadline: subheadline, email: email, password: password, confirmType: type))
            
        case .confirmEmailSuccess:
            return AnyView(EmailConfirmationCompleteView())
            
        // MARK: - Main App
            
        case .tabViewManager:
            return AnyView(TabViewManager())
            
        case .profileSetttings:
            return AnyView(ProfileSettingsView())
            
        case .changePasswordSettings:
            return AnyView(SettingsChangePasswordView())
            
        case .notificationSettings:
            return AnyView(SettingsNotificationsView())
        }
    }
    
}
