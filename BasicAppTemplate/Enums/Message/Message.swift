//
//  Message.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

enum MessageType: String, CaseIterable, Codable {
    case success
    case error
    case alert
    case info
    
    func getData() -> (color: Color, icon: String, title: String) {
        switch self {
        case .success:
            return (.accentColor, "checkmark.circle", "Success")
        case .error:
            return (.red, "xmark.circle", "Error")
        case .alert:
            return (.yellow, "exclamationmark.triangle", "Alert")
        case .info:
            return (.blue, "exclamationmark.circle", "Info")
        }
    }
}
