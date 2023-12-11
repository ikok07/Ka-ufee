//
//  NavigationManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI
import Observation

@Observable final class NavigationManager {
    
    var beforeAuthPath = NavigationPath()
    
    func navigate(to destination: NavigationDestination, path: CustomNavigationPath) {
        switch path {
        case .beforeAuth:
            beforeAuthPath.append(destination)
        }
    }
    
    func goToRoot(of path: CustomNavigationPath) {
        switch path {
        case .beforeAuth:
            beforeAuthPath = NavigationPath()
        }
    }
    
}
