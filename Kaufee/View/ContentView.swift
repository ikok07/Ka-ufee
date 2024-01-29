//
//  ContentView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(LoginStatus.self) private var loginStatusResults
    @Environment(NavigationManager.self) private var navManager
    @Environment(UXComponents.self) private var uxComponents
    @Environment(AccountManager.self) private var accManager
    
    var body: some View {
        @Bindable var uxComponents = self.uxComponents
        VStack {
            if let loginStatus = loginStatusResults.first {
                if loginStatus.isLoggedIn {
                    if navManager.hasSetup && !loginStatus.hasDetails {
                        SetupManager()
                    } else {
                        TabViewManager()
                    }
                } else {
                    LoginMainView()
                }
            } else {
                LoginMainView()
            }
        }
        .onChange(of: loginStatusResults, { oldValue, newValue in
            accManager.userLoaded = false
        })
        .animation(.default, value: loginStatusResults.first?.isLoggedIn)
        .animation(.default, value: loginStatusResults.first?.hasDetails)
    }
}

#Preview {
    ContentView()
        .environment(NavigationManager.shared)
        .environment(UXComponents.shared)
}
