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
    
    func getView() -> some View {
        switch self {
        case .login:
            return AnyView(LoginMainView())
        case .signUp:
            return AnyView(SignUpMainView())
        case .forgotPassword:
            return AnyView(ForgotPasswordEmailView())
        }
    }
    
}
