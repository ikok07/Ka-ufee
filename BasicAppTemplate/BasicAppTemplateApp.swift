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
        print(String(describing: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path))
        
        Backend.shared.config = BackendConfig(baseUrl: K.App.backendUrl, language: "en", errors: [])
        
        let loginStatus = AccountManager.getLoginStatus()
        if loginStatus == nil {
            AccountManager.createNewLoginStatus()
        }
    }
    
    @State private var navigationManager = NavigationManager.shared
    @State private var uxComponents = UXComponents.shared
    @State private var accManager = AccountManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(navigationManager)
                .environment(uxComponents)
                .environment(accManager)
                .onOpenURL(perform: { url in
                    Task {
                        await OpenURL.main.open(url: url)
                    }
                })
        }
    }
}
