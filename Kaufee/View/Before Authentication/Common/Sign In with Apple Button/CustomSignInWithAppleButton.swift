//
//  CustomSignInWithAppleButton.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI
import AuthenticationServices
import iOS_Backend_SDK
import RealmSwift


@MainActor
func getSignInWidthAppleButton(scheme: ColorScheme) -> some View {
    let nonce = Nonce()
    let state = Nonce()
    
    return SignInWithAppleButton(.continue) { request in
        UXComponents.shared.showLoader(text: "Signing in..." )
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.description
        request.state = state.description
    } onCompletion: { result in
        Task {
            await AccountManager.shared.signInWithApple(result: result, nonce: nonce)
        }
    }
    .signInWithAppleButtonStyle(scheme == .dark ? .white : .black)
}
