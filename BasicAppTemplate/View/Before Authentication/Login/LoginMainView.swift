//
//  LoginMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI

struct LoginMainView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(NavigationManager.self) private var navigationManager
    
    @StateObject var viewModel = ViewModel() // It's using the old way because of a bug with text fields
    
    @State private var email: String = ""
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.beforeAuthPath) {
            VStack(spacing: 30) {
                BeforeAuthHeadingView(icon: "building.columns.fill", heading: "Welcome to ", mainHeadingWord: "AppName", subheadline: "Login to continue")
                
                VStack(spacing: 15) {
                    DefaultTextField(text: $viewModel.email, icon: "envelope.fill", placeholder: "Your Email")
                        .validationType(.general)
                        .disableCapitalisation()
                    
                    DefaultTextField(text: $viewModel.password, icon: "key.horizontal.fill", placeholder: "Password")
                        .validationType(.general)
                        .isSecure()
                    
                    HStack {
                        Spacer()
                        Button("Forgot password?") {
                            navigationManager.navigate(to: .forgotPassword, path: .beforeAuth)
                        }
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    }
                    
                    DefaultButton(text: "Log in", isLoading: viewModel.loading) {
                        Task {
                            await viewModel.performLogin()
                        }
                    }
                    
                    MethodDividerView()
                        .padding()
                    
                    getSignInWidthAppleButton(scheme: colorScheme)
                        .frame(height: 40)
                        .padding(.horizontal)
                    
                    SignInWithGoogleButton()
                        .padding(.horizontal)
                    
                    HStack(spacing: 5) {
                        Text("Don't have an account?")
                            .foregroundStyle(.gray)
                        Button("Sign Up") {
                            navigationManager.navigate(to: .signUp, path: .beforeAuth)
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.medium)
                }
                
                Spacer()
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .padding(.top)
            .withNavigationDestinations()
            
        }
    }
}

#Preview {
    LoginMainView()
        .environment(NavigationManager())
}
