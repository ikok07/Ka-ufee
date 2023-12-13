//
//  Navigator.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import Foundation

struct Navigator {
    
    var navigationManager: NavigationManager?
    
    static var main = Navigator()
    private init() {}
    
    func navigate(to destination: NavigationDestination, path: CustomNavigationPath) {
        navigationManager?.navigate(to: destination, path: path)
    }
    
    func goToRoot(ofPath path: CustomNavigationPath) {
        navigationManager?.goToRoot(of: path)
    }
    
}
