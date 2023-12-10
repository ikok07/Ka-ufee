//
//  LoginMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI

struct LoginMainView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "building.columns.fill", heading: "Welcome to ", mainHeadingWord: "AppName", subheadline: "Login to continue")
            
            VStack(spacing: 15) {
                DefaultTextField(icon: "envelope.fill", placeholder: "Your Email")
                    .validationType(.email)
                
                DefaultTextField(icon: "key.horizontal.fill", placeholder: "Password")
                    .validationType(.password)
            }
            
            Spacer()
        }
        .padding()
        .padding(.top)
    }
}

#Preview {
    LoginMainView()
}
