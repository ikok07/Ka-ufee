//
//  User.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import Foundation
import RealmSwift

final class User: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var token: String?
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var photo: String
    @Persisted var details: UserDetails?
    
    convenience init(_id: ObjectId, token: String?, name: String, email: String, photo: String) {
        self.init()
        self._id = _id
        self.token = token
        self.name = name
        self.email = email
        self.photo = photo
    }
}
