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
        guard let loginStatus else {
            AccountManager.createNewLoginStatus()
            return
        }
    }
    
    @State private var navigationManager = NavigationManager()
    @State private var uxComponents = UXComponents()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .overlay {
                    VStack {
                        CustomMessage(isActive: uxComponents.showMessage, type: uxComponents.messageType, text: uxComponents.messageText)
                            .environment(uxComponents)
                            .padding(.top)
                            .animation(.bouncy, value: uxComponents.showMessage)
                        Spacer()
                    }
                }
                .environment(navigationManager)
                .onAppear {
                    Navigator.main.navigationManager = navigationManager
                    Components.shared.uxComponents = uxComponents
                }
        }
    }
}
