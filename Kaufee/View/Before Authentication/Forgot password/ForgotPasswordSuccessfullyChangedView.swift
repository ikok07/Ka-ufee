//
//  ForgotPasswordSuccessfullyChangedView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI

struct ForgotPasswordSuccessfullyChangedView: View {
    
    @Environment(AccountManager.self) private var accManager
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.icloud.fill", heading: "Password successfully changed", mainHeadingWord: "", subheadline: "Your new password is now active")
            
            DefaultButton(text: "Continue") {
                Task {
                    await accManager.finishEmailVerification()
                }
            }
            
            Spacer()
        }
        .padding()
        .padding(.top)
    }
}

#Preview {
    ForgotPasswordSuccessfullyChangedView()
}
