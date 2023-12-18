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
    
    func withCustomMessage(uxComponents: UXComponents) -> some View {
        self.modifier(WithCustomMessage(uxComponents: uxComponents))
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

struct WithCustomMessage: ViewModifier {
    
    let uxComponents: UXComponents
    
    func body(content: Content) -> some View {
        content
            .overlay {
                VStack {
                    CustomMessage(isActive: uxComponents.showMessage, type: uxComponents.messageType, text: uxComponents.messageText)
                        .environment(uxComponents)
                        .padding(.top)
                        .animation(.bouncy, value: uxComponents.showMessage)
                    Spacer()
                }
            }
    }
    
}

