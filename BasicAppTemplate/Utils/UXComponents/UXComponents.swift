//
//  UXComponents.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI
import Observation

@Observable final class UXComponents {
    
    var showMessage: Bool = false
    var messageType: MessageType = .error
    var messageText: String = ""
    
}
