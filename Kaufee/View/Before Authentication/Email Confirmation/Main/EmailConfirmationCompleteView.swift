//
//  EmailConfirmationCompleteView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI
import RealmSwift
import iOS_Backend_SDK

struct EmailConfirmationCompleteView: View {
    
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    
    @ObservedResults(LoginStatus.self) private var loginStatusResults
    @ObservedResults(User.self) private var userResults
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "shield.lefthalf.filled.badge.checkmark", heading: "Authentication successfull", mainHeadingWord: "", subheadline: "Your identity is now verified")
            
            DefaultButton(text: "Continue") {
                Task {
                    await accManager.finishEmailVerification()
                }
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
        .environment(NavigationManager.shared)
}
