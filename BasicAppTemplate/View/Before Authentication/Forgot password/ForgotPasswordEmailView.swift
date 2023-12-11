//
//  ForgotPasswordEmailView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

struct ForgotPasswordEmailView: View {
    
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.rotation", heading: "Restore your password", mainHeadingWord: "", subheadline: "Enter email to continue")
            
            DefaultTextField(text: $email, icon: "envelope.fill", placeholder: "Your email")
            
            DefaultButton(text: "Continue") {
                
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordEmailView()
}
