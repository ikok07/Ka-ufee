//
//  SettingsViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import Foundation
import Observation
import RealmSwift

extension SettingsMainView {
    
    @Observable final class ViewModel {
        
        @MainActor func logOut() async {
            let loginStatusResults: Results<LoginStatus>? = DB.shared.fetch()
            let userResults: Results<User>? = DB.shared.fetch()
            
            if let loginStatus = loginStatusResults?.first?.thaw() {
                DB.shared.update {
                    loginStatus.logOut()
                }
            }
            
            if let user = userResults?.first {
                do {
                    try DB.shared.delete(user)
                } catch {
                    UXComponents.shared.showMsg(type: .error, text: CustomError.cannotLogOut.rawValue)
                }
            }
        }
        
    }
    
}
