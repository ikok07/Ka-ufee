//
//  AccountManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift
import Observation
import iOS_Backend_SDK

@Observable final class AccountManager {
    
    var user: User?

    init() {
        let userResults: Results<User>? = DB.shared.fetch()
        if let user = userResults?.first {
            self.user = user
        }
    }
}
