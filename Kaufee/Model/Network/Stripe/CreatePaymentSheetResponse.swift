//
//  CreatePaymentSheetResponse.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import Foundation


struct CreatePaymentSheetResponse: Codable {
    let paymentIntent: String?
    let ephemeralKey: String?
    let customer: String?
    let publishableKey: String?
    let message: String?
    let identifier: String?
}
