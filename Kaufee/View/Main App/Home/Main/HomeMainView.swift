//
//  HomeMainView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI
import RealmSwift

struct HomeMainView: View {
    
    @ObservedResults(User.self) private var userResults
    
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    @Environment(UXComponents.self) private var uxComponents
    
    var body: some View {
        @Bindable var navManager = navManager

        
        NavigationStack(path: $navManager.homePath) {
            if userResults.first?.role == "business" {
                BusinessHomeView()
            } else {
                CustomerHomeView()
            }
        }
    }
}

#Preview {
    HomeMainView()
        .environment(NavigationManager.shared)
        .environment(AccountManager.shared)
        .environment(UXComponents.shared)
}
