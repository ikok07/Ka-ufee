//
//  UXComponentsSingleton.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import Foundation

struct Components {
    
    static var shared = Components()
    private init() {}
    
    var uxComponents: UXComponents?
    
    func showMessage(type: MessageType, text: String) {
        uxComponents?.messageType = type
        uxComponents?.messageText = text
        uxComponents?.showMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            uxComponents?.showMessage = false
        }
    }
}
