//
//  ViewModifier.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

extension View {
    
    func withNavigationDestinations() -> some View {
        self.modifier(NavigationDestinationModifier())
    }
    
}


struct NavigationDestinationModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationDestination.self) { destination in
                destination.getView()
            }
    }
}

