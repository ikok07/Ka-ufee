//
//  ContentView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(LoginStatus.self) private var loginStatusResults
    @Environment(NavigationManager.self) private var navManager
    
    var body: some View {
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
        .animation(.default, value: loginStatusResults.first?.isLoggedIn)
        .animation(.default, value: loginStatusResults.first?.hasDetails)
    }
}

#Preview {
    ContentView()
        .environment(NavigationManager.shared)
}
