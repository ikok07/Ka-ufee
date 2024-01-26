//
//  UserType.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation

enum UserType: String, CaseIterable, Codable {
    case customer = "Customer"
    case business = "Business"
}
