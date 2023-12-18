//
//  Account.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 18.12.23.
//

import Foundation

struct Account {
    
    static var shared = Account()
    private init() {}
    
    var accManager: AccountManager?
    
    func updateUser(with user: User) {
        accManager?.user = user
    }
    
}
