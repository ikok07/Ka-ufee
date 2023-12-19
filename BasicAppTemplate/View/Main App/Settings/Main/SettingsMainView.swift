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
    @Environment(UXComponents.self) private var uxComponents
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        @Bindable var navManager = navManager
        
        NavigationStack(path: $navManager.settingsPath) {
            List {
                Section("Your profile") {
                    SettingsMainPageUserView(imageUrl: accManager.user?.photo ?? "https://", username: accManager.user?.name ?? "No username", email: accManager.user?.email ?? "No email")
                }
                
                Section("General settings") {
                    ListCustomButton(icon: "person.circle", label: "Profile settings", hasChevron: true) {
                        Navigator.main.navigate(to: .profileSetttings, path: .settings)
                    }
                    
                    ListCustomButton(icon: "key.horizontal", label: "Change password", hasChevron: true) {
                        Navigator.main.navigate(to: .profileSetttings, path: .settings)
                    }
                    
                    ListCustomButton(icon: "bell", label: "Notifications", hasChevron: true) {
                        Navigator.main.navigate(to: .profileSetttings, path: .settings)
                    }
                }
                
                Section("Danger zone") {
                    ListCustomButton(icon: "rectangle.portrait.and.arrow.forward", label: "Log out", hasChevron: false) {
                        Task {
                            await viewModel.logOut()
                        }
                    }
                    .buttonPadding(0)
                    .iconFont(.title3)
                    .iconColor(.red)
                    .textColor(.red)
                }
            }
            .navigationTitle("Settings")
            .withNavigationDestinations()
        }
        .withCustomMessage(uxComponents: self.uxComponents)
        
    }
}

#Preview {
    SettingsMainView()
        .environment(NavigationManager())
        .environment(AccountManager())
        .environment(UXComponents())
}
