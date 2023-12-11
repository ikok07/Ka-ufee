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
    
    var body: some View {
        VStack {
            if let loginStatus = loginStatusResults.first {
                if loginStatus.isLoggedIn {
                    
                } else {
                    LoginMainView()
                }
            } else {
                LoginMainView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
