//
//  EmailConfirmationView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

struct EmailConfirmationView: View {
    
    let title: String
    let subheadline: String
    
    @State private var openEmailSheetActive: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "envelope.fill", heading: title, mainHeadingWord: "", subheadline: subheadline)
            
            DefaultButton(text: "Open email", icon: "paperplane.fill") {
                openEmailSheetActive = true
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
    }
}

#Preview {
    NavigationStack {
        EmailConfirmationView(title: "Confirm your email", subheadline: "An email was sent to you")
    }
}
