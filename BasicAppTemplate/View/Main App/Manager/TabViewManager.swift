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
            VStack {
                Text("Home page")
                Button("Log Out") {
                    if let loginStatus = loginStatusResults.first?.thaw() {
                        DB.shared.update {
                            loginStatus.logOut()
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabViewManager()
}