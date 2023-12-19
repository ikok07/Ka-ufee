//
//  TabViewManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI
import RealmSwift

struct TabViewManager: View {
    
    @Bindable private var viewModel = ViewModel()
    @ObservedResults(LoginStatus.self) private var loginStatusResults
    
    var body: some View {
        TabView(selection: viewModel.tabSelection()) {
            Text("Home page")
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)
            
            SettingsMainView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(Tab.settings)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabViewManager()
        .environment(NavigationManager())
        .environment(AccountManager())
}
