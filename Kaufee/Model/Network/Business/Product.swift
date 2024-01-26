//
//  Product.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation
import RealmSwift

struct Product: Codable, Hashable {
    let businessId: ObjectId
    let name: String
    let description: String
    let image: String?
    let price: Double
    let currency: String
    let metadata: StandardMetadata
}
