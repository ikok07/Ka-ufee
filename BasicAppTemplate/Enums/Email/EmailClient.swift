//
//  EmailClient.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

enum EmailClient: String, CaseIterable, Codable {
    case apple, gmail, outlook
    
    func openEmail() {
        switch self {
        case .apple:
            UIApplication.shared.open(URL(string: "message://")!)
        case .gmail:
            UIApplication.shared.open(URL(string: "googlegmail://")!)
        case .outlook:
            UIApplication.shared.open(URL(string: "ms-outlook://")!)
        }
    }
}
