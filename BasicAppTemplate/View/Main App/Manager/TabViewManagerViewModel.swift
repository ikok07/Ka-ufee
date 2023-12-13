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
                        if Navigator.main.navigationManager?.homePath.isEmpty ?? false {
                            self.scrollHomePage.toggle()
                        } else {
                            Navigator.main.goToRoot(ofPath: .home)
                        }
                    case .settings:
                        if Navigator.main.navigationManager?.settingsPath.isEmpty ?? false {
                            self.scrollSettingsPage.toggle()
                        } else {
                            Navigator.main.goToRoot(ofPath: .settings)
                        }
                    }
                }
                self.selection = tappedTab
            }
        }
        
    }
    
}
