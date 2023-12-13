//
//  SetupViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI
import Observation
import RealmSwift

extension SetupManager {
    
    @Observable final class ViewModel {
        
        var activePage: Int = 1
        
        @MainActor func finishSetup() async {
            
            // upload user details
            
            let loginStatusResults: Results<LoginStatus>? = DB.shared.fetch()
            if let loginStatus = loginStatusResults?.first {
                DB.shared.update {
                    loginStatus.hasDetails = true
                }
            }
        }
        
    }
    
}
