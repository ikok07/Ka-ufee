//
//  Business.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation
import RealmSwift


struct Business: Codable, Hashable {
    let userId: ObjectId
    let name: String
    let description: String
    let image: String?
    let products: [Product]
    let metadata: StandardMetadata
}


