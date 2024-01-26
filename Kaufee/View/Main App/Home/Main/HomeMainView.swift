//
//  HomeMainView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct HomeMainView: View {
    
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    @Environment(UXComponents.self) private var uxComponents
    
    var body: some View {
        @Bindable var navManager = navManager

        
        NavigationStack(path: $navManager.homePath) {
            ZStack {
                Color(.listBackground)
                    .ignoresSafeArea()
                
                if accManager.user?.role == "business" {
                    BusinessHomeView()
                } else {
                    CustomerHomeView()
                }
            }
        }
        .withCustomMessage()
        .withWholeScreenLoader()
    }
}

#Preview {
    HomeMainView()
        .environment(NavigationManager.shared)
        .environment(AccountManager.shared)
        .environment(UXComponents.shared)
}
