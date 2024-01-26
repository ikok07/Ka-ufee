//
//  TextFieldValidationType.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import Foundation

enum TextFieldValidationType: String, CaseIterable, Codable {
    case none
    case general
    case email
    case password
    case confirmPassword
}
