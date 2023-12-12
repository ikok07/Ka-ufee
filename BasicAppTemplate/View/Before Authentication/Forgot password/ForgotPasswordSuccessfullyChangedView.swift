//
//  ForgotPasswordSuccessfullyChangedView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI

struct ForgotPasswordSuccessfullyChangedView: View {
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.icloud.fill", heading: "Password successfully changed", mainHeadingWord: "", subheadline: "Your new password is now active")
            
            DefaultButton(text: "Continue") {
                
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
