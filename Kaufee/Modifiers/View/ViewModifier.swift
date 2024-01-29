//
//  ViewModifier.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

extension View {
    
    func withNavigationDestinations() -> some View {
        self.modifier(NavigationDestinationModifier())
    }
    
    func withCustomMessage() -> some View {
        self.modifier(WithCustomMessage())
    }
    
    func withWholeScreenLoader() -> some View {
        self.modifier(WithWholeScreenLoader())
    }
    
    func withAccountDeletedAlert() -> some View {
        self.modifier(WithAccountDeletedAlert())
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
    func body(content: Content) -> some View {
        content
            .overlay {
                VStack {
                    CustomMessage(isActive: UXComponents.shared.showMessage, type: UXComponents.shared.messageType, text: UXComponents.shared.messageText)
                        .environment(UXComponents.shared)
                        .padding(.top)
                        .animation(.bouncy, value: UXComponents.shared.showMessage)
                    Spacer()
                }
            }
    }
}

struct WithWholeScreenLoader: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .overlay {
                WholeScreenLoader()
                    .animation(.default, value: UXComponents.shared.showWholeScreenLoader)
            }
    }
}

struct WithAccountDeletedAlert: ViewModifier {
    
    @Environment(UXComponents.self) private var uxComponents
    @Environment(AccountManager.self) private var accManager
    
    func body(content: Content) -> some View {
        @Bindable var uxComponents = self.uxComponents
        
        content
        .alert("Account deleted", isPresented: $uxComponents.showAccountDeleted) {
            Button("Done", action: {
                Task {
                    await accManager.logout(force: true)
                    uxComponents.showWholeScreenLoader = false
                    uxComponents.showAccountDeleted = false
                }
            })
        } message: {
            Text("Please note that it may take up to a day to fully delete your data.")
        }
    }
    
}

