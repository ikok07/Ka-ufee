//
//  NavigationManager.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI
import Observation

@Observable final class NavigationManager {
    
    static let shared = NavigationManager()
    private init() {}
    
    var hasSetup: Bool = false
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
    
    func clearPaths() {
        self.beforeAuthPath = .init()
        self.homePath = .init()
        self.settingsPath = .init()
    }
    
}
