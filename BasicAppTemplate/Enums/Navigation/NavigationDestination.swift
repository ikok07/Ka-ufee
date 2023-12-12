//
//  NavigationDestination.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case login
    case signUp
    case forgotPassword
    case confirmEmail(title: String, subheadline: String)
    case confirmEmailSuccess
    
    func getView() -> some View {
        switch self {
        case .login:
            return AnyView(LoginMainView())
        case .signUp:
            return AnyView(SignUpMainView())
        case .forgotPassword:
            return AnyView(ForgotPasswordEmailView())
        case .confirmEmail(let title, let subheadline):
            return AnyView(EmailConfirmationView(title: title, subheadline: subheadline))
        case .confirmEmailSuccess:
            return AnyView(EmailConfirmationCompleteView())
        }
    }
    
}
