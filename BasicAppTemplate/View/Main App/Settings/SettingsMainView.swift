//
//  SettingsMainView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct SettingsMainView: View {
    
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    
    var body: some View {
        @Bindable var navManager = navManager
        
        NavigationStack(path: $navManager.settingsPath) {
            VStack {
                SettingsMainPageUserView(imageUrl: accManager.user?.photo ?? "https://", username: accManager.user?.name ?? "No username", email: accManager.user?.email ?? "No email")
                
                Spacer()
            }
            .navigationTitle("Settings")
            .padding()
        }
    }
}

#Preview {
    SettingsMainView()
        .environment(NavigationManager())
        .environment(AccountManager())
}
