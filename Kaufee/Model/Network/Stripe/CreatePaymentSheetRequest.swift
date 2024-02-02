//
//  CreatePaymentSheetRequest.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import Foundation

struct CreatePaymentSheetRequest: Codable {
    let price: Double
    let currency: String
}
