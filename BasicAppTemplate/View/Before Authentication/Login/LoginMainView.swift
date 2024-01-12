//
//  LoginMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI
import UserNotifications

struct LoginMainView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(UXComponents.self) private var uxComponents
    
    @StateObject var viewModel = ViewModel() // It's using the old way because of a bug with text fields
    
    @State private var email: String = ""
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.beforeAuthPath) {
            ScrollView {
                
                VStack(spacing: 30) {
                    BeforeAuthHeadingView(icon: "building.columns.fill", heading: "Welcome to ", mainHeadingWord: "AppName", subheadline: "Login to continue")
                    
                    VStack(spacing: 15) {
                        DefaultTextField(text: $viewModel.email, icon: "envelope.fill", placeholder: "Your Email", validation: $viewModel.validations[0])
                            .validationType(.general)
                            .disableCapitalisation()
                        
                        DefaultTextField(text: $viewModel.password, icon: "key.horizontal.fill", placeholder: "Password", validation: $viewModel.validations[1])
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
                        
                        DefaultButton(
                            text: "Log in",
                            isDisabled: viewModel.validations != Array(repeating: true, count: 2),
                            isLoading: viewModel.loading
                        ) {
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
                .scrollIndicators(.hidden)
                .onChange(of: viewModel.validations) { _, newValue in
                    print(newValue)
                }
            }
            
        }
        .withCustomMessage(uxComponents: self.uxComponents)
    }
}

#Preview {
    LoginMainView()
        .environment(NavigationManager.shared)
        .environment(UXComponents.shared)
}
