//
//  EmailConfirmationCompleteView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI

struct EmailConfirmationCompleteView: View {
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "shield.lefthalf.filled.badge.checkmark", heading: "Authentication successfull", mainHeadingWord: "", subheadline: "Your identity is now verified")
            
            DefaultButton(text: "Continue") {
                
            }
            Spacer()
        }
        .navigationTitle("Confirmation")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top)
    }
}

#Preview {
    EmailConfirmationCompleteView()
}
