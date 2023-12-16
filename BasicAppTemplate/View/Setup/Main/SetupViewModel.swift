//
//  SetupViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI
import Observation
import RealmSwift
import iOS_Backend_SDK

extension SetupManager {
    
    @Observable final class ViewModel {
        
        var activePage: Int = 1
        
        @MainActor func finishSetup() async {
            
            let userResults: Results<User>? = DB.shared.fetch()
            
            // upload user details
            if let user = userResults?.first {
                
                // ------ Not available when testing ------
                
//                await Backend.shared.createUserDetails(userId: user._id.stringValue, token: user.token ?? "") { result in
//                    switch result {
//                    case .success(let response):
//                        let loginStatusResults: Results<LoginStatus>? = DB.shared.fetch()
//                        if let loginStatus = loginStatusResults?.first {
//                            DB.shared.update {
//                                loginStatus.hasDetails = true
//                            }
//                        }
//                    case .failure(let error):
//                        Components.shared.showMessage(type: .error, text: error.localizedDescription)
//                        return
//                    }
//                }
                
                // ------ Not available when testing ------
                
                // ------ Temporary ------
                
                let userDetails = UserDetails(_id: try! ObjectId(string: "65463e952f159b07f4dc6913"), userId: UUID().uuidString)
                DB.shared.save(userDetails)
                
                let loginStatusResults: Results<LoginStatus>? = DB.shared.fetch()
                let userDetailsResults: Results<UserDetails>? = DB.shared.fetch()
                
                // ------ Temporary ------
                
                if let loginStatus = loginStatusResults?.first, userDetailsResults?.first != nil {
                    DB.shared.update {
                        loginStatus.hasDetails = true
                    }
                }
                
            } else {
                Components.shared.showMessage(type: .error, text: CustomError.NoUserAvailable.rawValue)
            }
            
        }
        
    }
    
}
