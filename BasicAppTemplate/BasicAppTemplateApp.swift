//
//  BasicAppTemplateApp.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI
import iOS_Backend_SDK

@main
struct BasicAppTemplateApp: App {
    
    let migrator = RealmMigrator()
    
    init() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path)
        
        Backend.shared.config = BackendConfig(baseUrl: "https://api.wellsavor.com", language: "en", errors: [])
        
        let loginStatus = AccountManager.getLoginStatus()
        if loginStatus == nil {
            AccountManager.createNewLoginStatus()
        }
    }
    
    @State private var navigationManager = NavigationManager()
    @State private var uxComponents = UXComponents()
    @State private var accManager = AccountManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navigationManager)
                .environment(uxComponents)
                .environment(accManager)
                .onAppear {
                    Navigator.main.navigationManager = navigationManager
                    Components.shared.uxComponents = uxComponents
                    Account.shared.accManager = accManager
                }
                .onOpenURL(perform: { url in
                    Task {
                        await OpenURL.main.open(url: url)
                    }
                })
        }
    }
}
