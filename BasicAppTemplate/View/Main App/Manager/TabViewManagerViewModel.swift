//
//  TabViewManagerViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI
import Observation

extension TabViewManager {
    
    @Observable final class ViewModel {
        
        var selection: Tab = .home
        
        var scrollHomePage: Bool = false
        var scrollSettingsPage: Bool = false
        
        func tabSelection() -> Binding<Tab> {
            Binding {
                self.selection
            } set: { tappedTab in
                if tappedTab == self.selection {
                    switch tappedTab {
                    case .home:
                        if NavigationManager.shared.homePath.isEmpty {
                            self.scrollHomePage.toggle()
                        } else {
                            NavigationManager.shared.goToRoot(of: .home)
                        }
                    case .settings:
                        if NavigationManager.shared.settingsPath.isEmpty {
                            self.scrollSettingsPage.toggle()
                        } else {
                            NavigationManager.shared.goToRoot(of: .settings)
                        }
                    }
                }
                self.selection = tappedTab
            }
        }
        
    }
    
}
