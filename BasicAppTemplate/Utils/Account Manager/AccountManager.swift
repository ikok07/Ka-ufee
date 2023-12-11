//
//  AccountManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift
import Observation

@Observable final class AccountManager {
    
    static func getLoginStatus() -> LoginStatus? {
        let results: Results<LoginStatus>? = DB.shared.fetch()
        guard let results else {
            return nil
        }
        
        if let loginStatus = results.first {
            return loginStatus
        }
        
        return nil
    }
    
    static func createNewLoginStatus() {
        var loginStatus = LoginStatus(isLoggedIn: false, hasDetails: false)
        DB.shared.save(loginStatus)
    }
    
    
    
}
