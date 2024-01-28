//
//  SettingsMainView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI
import RealmSwift

struct SettingsMainView: View {
    
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    @Environment(UXComponents.self) private var uxComponents
    
    @State private var viewModel = ViewModel()
    
    @ObservedResults(User.self) var userResults
    
    var body: some View {
        @Bindable var navManager = navManager
        
        NavigationStack(path: $navManager.settingsPath) {
            List {
                Section("Your profile") {
                    SettingsMainPageUserView(imageUrl: userResults.first?.photo ?? "https://", username: userResults.first?.name ?? "No username", email: userResults.first?.email ?? "No email")
                }
                
                Section("General settings") {
                    ListCustomButton(icon: "person.circle", label: "Profile settings", hasChevron: true) {
                        NavigationManager.shared.navigate(to: .profileSetttings, path: .settings)
                    }
                    
                    if userResults.first?.oauthProvider == "local" {
                        ListCustomButton(icon: "key.horizontal", label: "Change password", hasChevron: true) {
                            NavigationManager.shared.navigate(to: .changePasswordSettings, path: .settings)
                        }
                    }
                    
                    ListCustomButton(icon: "bell", label: "Notifications", hasChevron: true) {
                        NavigationManager.shared.navigate(to: .notificationSettings, path: .settings)
                    }
                }
                
                Section("Danger zone") {
                    ListCustomButton(icon: "rectangle.portrait.and.arrow.forward", label: "Log out", hasChevron: false) {
                        Task {
                            await accManager.logout()
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
        .refreshable {
            await Task {
                await accManager.reloadUser()
            }.value
        }
    }
}

#Preview {
    SettingsMainView()
        .environment(NavigationManager.shared)
        .environment(AccountManager.shared)
        .environment(UXComponents.shared)
}
