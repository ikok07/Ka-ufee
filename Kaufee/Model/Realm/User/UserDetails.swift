//
//  UserDetails.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import Foundation
import RealmSwift

final class UserDetails: EmbeddedObject {
    @Persisted var _id: ObjectId
    @Persisted var userId: String
    
    convenience init(_id: ObjectId, userId: String) {
        self.init()
        self._id = _id
        self.userId = userId
    }
}
