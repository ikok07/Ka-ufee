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
            List {
                Section("Profile") {
                    SettingsMainPageUserView(imageUrl: accManager.user?.photo ?? "https://", username: accManager.user?.name ?? "No username", email: accManager.user?.email ?? "No email")
                }
                
                Section("General") {
                    SettingsNavigationButton(icon: "person.circle", label: "Profile settings", destination: .profileSetttings)
                    
                    SettingsNavigationButton(icon: "key.horizontal", label: "Change password", destination: .profileSetttings)
                    
                    SettingsNavigationButton(icon: "bell", label: "Notifications", destination: .profileSetttings)
                }

            }
            .navigationTitle("Settings")
            .withNavigationDestinations()
        }
        
    }
}

#Preview {
    SettingsMainView()
        .environment(NavigationManager())
        .environment(AccountManager())
}
