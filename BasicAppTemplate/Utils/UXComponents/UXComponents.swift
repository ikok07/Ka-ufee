//
//  UXComponents.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI
import Observation

@Observable final class UXComponents {
    
    static let shared = UXComponents()
    private init() {}
    
    var showMessage: Bool = false
    var messageType: MessageType = .error
    var messageText: String = ""
    
    func showMsg(type: MessageType, text: String) {
        showMessage = true
        messageType = type
        messageText = text
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMessage = false
        }
    }
    
}
