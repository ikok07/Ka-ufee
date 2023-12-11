//
//  SignUpMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

struct SignUpMainView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(NavigationManager.self) private var navigationManager
    
    @State private var name: String = ""
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "building.columns.fill", heading: "Start your adventure", mainHeadingWord: "", subheadline: "Create a new account")
            
            VStack(spacing: 15) {
                DefaultTextField(text: $name, icon: "person.fill", placeholder: "Full name")
                    .validationType(.general)
                
                DefaultTextField(text: $name, icon: "envelope.fill", placeholder: "Your email")
                    .validationType(.email)
                
                DefaultTextField(text: $name, icon: "key.horizontal.fill", placeholder: "Password")
                    .validationType(.password)
                
                DefaultTextField(text: $name, icon: "key.horizontal.fill", placeholder: "Confirm password")
                    .validationType(.confirmPassword)
            }
            
            DefaultButton(text: "Sign up") {
                
            }
            
            MethodDividerView()
            
            VStack(spacing: 15) {
                getSignInWidthAppleButton(scheme: colorScheme)
                    .frame(height: 40)
                    .padding(.horizontal)
                
                SignInWithGoogleButton()
                    .padding(.horizontal)
            }
            
            HStack(spacing: 5) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                Button("Log in") {
                    navigationManager.navigate(to: .login, path: .beforeAuth)
                }
            }
            .font(.subheadline)
            .fontWeight(.medium)
            
            Spacer()
        }
        .navigationTitle("Sign up")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top)
    }
}

#Preview {
    SignUpMainView()
        .environment(NavigationManager())
}
