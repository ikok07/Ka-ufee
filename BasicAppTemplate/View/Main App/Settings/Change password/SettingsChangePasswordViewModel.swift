//
//  SettingsChangePasswordViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 19.12.23.
//

import Foundation
import Observation
import iOS_Backend_SDK
import RealmSwift

extension SettingsChangePasswordView {
    
    @Observable final class ViewModel {
        
        var currentPassword: String = .init()
        var newPassword: String = .init()
        var confirmNewPassword: String = .init()
        
        var validation: [Bool] = Array(repeating: false, count: 3)
        var isLoading: Bool = false
        var resetTextFields: Bool = false
        
        func buttonActive() -> Bool {
            if !isLoading {
                return validation == Array(repeating: true, count: 3)
            } else {
                return !isLoading
            }
        }
        
        @MainActor func saveNewPassword() async {
            if let user = Account.shared.accManager?.user?.thaw() {
                self.isLoading = true
                await Backend.shared.resetPasswordByCurrentPassword(password: self.currentPassword, newPassword: self.newPassword, newPasswordConfirm: self.confirmNewPassword, authToken: user.token ?? "") { result in
                    switch result {
                    case .success(let response):
                        DB.shared.update {
                            user.token = response.token
                            self.validation = Array(repeating: false, count: 3)
                            self.currentPassword = .init()
                            self.newPassword = .init()
                            self.confirmNewPassword = .init()
                            self.resetTextFields.toggle()
                            Components.shared.showMessage(type: .success, text: "Settings successfully saved")
                        }
                    case .failure(let error):
                        Components.shared.showMessage(type: .error, text: error.localizedDescription)
                    }
                    self.isLoading = false
                }
                
            } else {
                Components.shared.showMessage(type: .error, text: CustomError.NoUserAvailable.rawValue)
            }
            
        }
        
    }
    
}
