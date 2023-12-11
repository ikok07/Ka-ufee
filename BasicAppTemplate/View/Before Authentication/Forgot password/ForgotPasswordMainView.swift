//
//  ForgotPasswordMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

struct ForgotPasswordMainView: View {
    
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "lock.rotation", heading: "Restore your password", mainHeadingWord: "", subheadline: "Write your new password")
            
            VStack(spacing: 15) {
                DefaultTextField(text: $newPassword, icon: "key.horizontal.fill", placeholder: "New password")
                    .validationType(.password)
                
                DefaultTextField(text: $newPassword, icon: "key.horizontal.fill", placeholder: "New password")
                    .validationType(.confirmPassword, mainPassword: newPassword)
            }
            
            DefaultButton(text: "Restore password") {
                
            }
            Spacer()
        }
        .padding()
        .padding(.top)
    }
}

#Preview {
    ForgotPasswordMainView()
}
