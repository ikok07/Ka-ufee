//
//  OpenURLMethods.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import Foundation
import RealmSwift
import iOS_Backend_SDK

extension OpenURL {
    
    /// Before executing this method, make sure that you have passed email to the shared instance
    internal func confirmEmail(token: String, isTwoFa: Bool, appSecurityTokenId: String?) async {
        
        if isTwoFa {
            await Backend.shared.loginConfirm(email: self.email, token: token, deviceToken: NotificationManager.shared.deviceToken, appSecurityTokenId: appSecurityTokenId) { result in
                switch result {
                case .success(let response):
                    if let backendUser = response.data?.user {
                        do {
                            try self.createNewUser(backendUser: backendUser, token: response.token ?? "")
                        } catch {
                            UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
                self.email = ""
            }
        } else {
            await Backend.shared.emailConfirm(email: self.email, token: token, deviceToken: NotificationManager.shared.deviceToken, appSecurityTokenId: appSecurityTokenId) { result in
                switch result {
                case .success(let response):
                    if let backendUser = response.data?.user {
                        do {
                            try self.createNewUser(backendUser: backendUser, token: response.token ?? "")
                        } catch {
                            UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
                self.email = ""
            }
        }
        
    }
    
    private func createNewUser(backendUser: BackendUser, token: String) throws {
        let user = AccountManager.convertBackendUser(backendUser, token: token)
        
        do {
            try DB.shared.save(user)
            NavigationManager.shared.navigate(to: .confirmEmailSuccess, path: .beforeAuth)
        } catch {
            throw error
        }
    }
}
