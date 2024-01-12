//
//  ForgotPasswordEmailView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI
import iOS_Backend_SDK

struct ForgotPasswordEmailView: View {
    
    @State private var isLoading: Bool = false
    
    @State private var email: String = ""
    @State private var validation: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.rotation", heading: "Forgot your password?", mainHeadingWord: "", subheadline: "Enter email to continue")
            
            DefaultTextField(text: $email, icon: "envelope.fill", placeholder: "Your email", validation: $validation)
                .validationType(.email)
                .disableCapitalisation()
            
            DefaultButton(text: "Continue", isDisabled: !validation, isLoading: self.isLoading) {
                Task {
                    await sendResetPasswordEmail()
                }
            }
            
            Spacer()
        }
        .navigationTitle("Forgot password")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top)
        .onSubmit {
            if validation {
                Task {
                    await sendResetPasswordEmail()
                }
            }
        }
    }
    
    func sendResetPasswordEmail() async {
        self.isLoading = true
        OpenURL.main.email = self.email
        await Backend.shared.requestResetPassword(email: self.email) { result in
            switch result {
            case .success(_):
                NavigationManager.shared.navigate(to: .confirmEmail(title: "Verify your identity", subheadline: "An email was sent to you", email: self.email, type: .forgotPassword), path: .beforeAuth)
            case .failure(let error):
                UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
            }
        }
        self.isLoading = false
    }
    
}

#Preview {
    ForgotPasswordEmailView()
}
