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
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.rotation", heading: "Forgot your password?", mainHeadingWord: "", subheadline: "Enter email to continue")
            
            DefaultTextField(text: $email, icon: "envelope.fill", placeholder: "Your email")
                .validationType(.email)
                .disableCapitalisation()
            
            DefaultButton(text: "Continue", isLoading: self.isLoading) {
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
    }
    
    func sendResetPasswordEmail() async {
        self.isLoading = true
        OpenURL.main.email = self.email
        await Backend.shared.requestResetPassword(email: self.email) { result in
            switch result {
            case .success(_):
                Navigator.main.navigate(to: .confirmEmail(title: "Verify your identity", subheadline: "An email was sent to you"), path: .beforeAuth)
            case .failure(let error):
                Components.shared.showMessage(type: .error, text: error.localizedDescription)
            }
        }
        self.isLoading = false
    }
    
}

#Preview {
    ForgotPasswordEmailView()
}
