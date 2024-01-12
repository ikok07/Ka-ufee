//
//  EmailConfirmationView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI
import iOS_Backend_SDK

struct EmailConfirmationView: View {
    
    let title: String
    let subheadline: String
    let email: String
    var password: String = ""
    let confirmType: EmailConfirmType
    
    @State private var openEmailSheetActive: Bool = false
    @State private var resendButtonDisabled: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "envelope.fill", heading: title, mainHeadingWord: "", subheadline: subheadline)
            
            VStack(spacing: 15) {
                DefaultButton(text: "Open email", icon: "paperplane.fill") {
                    openEmailSheetActive = true
                }
                
                Button("Resend email") {
                    Task {
                        switch self.confirmType {
                        case .signup:
                            await resendSignUpEmail()
                        case .login:
                            await resendLoginEmail()
                        case .forgotPassword:
                            await resendResetPasswordEmail()
                        }
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .disabled(self.resendButtonDisabled)
            }
            Spacer()
        }
        .navigationTitle("Confirmation")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top)
        .sheet(isPresented: $openEmailSheetActive, content: {
            AuthenticationOpenEmailSheetView()
                .presentationDetents([.height(300)])
        })
        .animation(.default, value: self.resendButtonDisabled)
    }
    
    func resendSignUpEmail() async {
        self.resendButtonDisabled = true
        await Backend.shared.resendEmail(email: self.email) { result in
            switch result {
            case .success(_):
                UXComponents.shared.showMsg(type: .success, text: "New email has been sent")
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.resendButtonDisabled = false
                }
            case .failure(let error):
                UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                self.resendButtonDisabled = false
            }
        }
    }
    
    func resendLoginEmail() async {
        self.resendButtonDisabled = true
        await Backend.shared.login(email: self.email, password: "") { result in
            switch result {
            case .success(_):
                UXComponents.shared.showMsg(type: .success, text: "New email has been sent")
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.resendButtonDisabled = false
                }
            case .failure(let error):
                UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                self.resendButtonDisabled = false
            }
        }
    }
    
    func resendResetPasswordEmail() async {
        self.resendButtonDisabled = true
        await Backend.shared.requestResetPassword(email: self.email) { result in
            switch result {
            case .success(_):
                UXComponents.shared.showMsg(type: .success, text: "New email has been sent")
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.resendButtonDisabled = false
                }
            case .failure(let error):
                UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                self.resendButtonDisabled = false
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        EmailConfirmationView(title: "Confirm your email", subheadline: "An email was sent to you", email: "email@email.com", confirmType: .signup)
    }
}
