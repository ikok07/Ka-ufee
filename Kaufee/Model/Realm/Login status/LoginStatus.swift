//
//  LoginStatus.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift

final class LoginStatus: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var date: Date = Date()
    @Persisted var isLoggedIn: Bool
    @Persisted var hasDetails: Bool
    
    func logOut() {
        try? realm?.write({
            self.hasDetails = false
            self.isLoggedIn = false
        })
    }
    
    convenience init(isLoggedIn: Bool, hasDetails: Bool) {
        self.init()
        self.isLoggedIn = isLoggedIn
        self.hasDetails = hasDetails
    }
}
