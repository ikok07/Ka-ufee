//
//  SettingsChangePasswordViewModel.swift
//  Kaufee
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
            if let user = AccountManager.shared.user?.thaw() {
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
                            UXComponents.shared.showMsg(type: .success, text: "Settings successfully saved")
                        }
                    case .failure(let error):
                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    }
                    self.isLoading = false
                }
                
            } else {
                UXComponents.shared.showMsg(type: .error, text: CustomError.noUserAvailable.localizedDescription)
            }
            
        }
        
    }
    
}
