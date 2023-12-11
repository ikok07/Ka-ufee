//
//  CustomSignInWithAppleButton.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI
import AuthenticationServices


func getSignInWidthAppleButton(scheme: ColorScheme) -> some View {
    return SignInWithAppleButton(.signIn) { request in
        request.requestedScopes = [.fullName, .email]
    } onCompletion: { result in
        switch result {
        case .success(let authResults):
            print("Authorisation successful \(authResults)")
        case .failure(let error):
            print("Authorisation failed: \(error.localizedDescription)")
        }
    }
    .signInWithAppleButtonStyle(scheme == .dark ? .white : .black)
}
