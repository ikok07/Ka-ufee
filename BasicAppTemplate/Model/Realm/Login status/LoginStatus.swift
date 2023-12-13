//
//  LoginStatus.swift
//  BasicAppTemplate
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
        self.hasDetails = false
        self.isLoggedIn = false
    }
    
    convenience init(isLoggedIn: Bool, hasDetails: Bool) {
        self.init()
        self.isLoggedIn = isLoggedIn
        self.hasDetails = hasDetails
    }
}
