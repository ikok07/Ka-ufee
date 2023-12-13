//
//  NavigationManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI
import Observation

@Observable final class NavigationManager {
    
    var hasSetup: Bool = true
    
    var beforeAuthPath = NavigationPath()
    
    var homePath = NavigationPath()
    var settingsPath = NavigationPath()
    
    func navigate(to destination: NavigationDestination, path: CustomNavigationPath) {
        switch path {
        case .beforeAuth:
            beforeAuthPath.append(destination)
        case .home:
            homePath.append(destination)
        case .settings:
            settingsPath.append(destination)
        }
    }
    
    func goToRoot(of path: CustomNavigationPath) {
        switch path {
        case .beforeAuth:
            beforeAuthPath = NavigationPath()
        case .home:
            homePath = NavigationPath()
        case .settings:
            settingsPath = NavigationPath()
        }
    }
    
}
