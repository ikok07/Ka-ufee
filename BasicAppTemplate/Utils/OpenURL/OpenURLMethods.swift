//
//  OpenURLMethods.swift
//  BasicAppTemplate
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
                        let user = User(_id: try! ObjectId(string: backendUser._id), token: response.token, name: backendUser.name, email: backendUser.email, photo: backendUser.photo)
                        
                        DB.shared.save(user, shouldBeOnlyOne: true, ofType: User.self)
                        NavigationManager.shared.navigate(to: .confirmEmailSuccess, path: .beforeAuth)
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
                        let user = User(_id: try! ObjectId(string: backendUser._id), token: response.token, name: backendUser.name, email: backendUser.email, photo: backendUser.photo)
                        
                        DB.shared.save(user, shouldBeOnlyOne: true, ofType: User.self)
                        NavigationManager.shared.navigate(to: .confirmEmailSuccess, path: .beforeAuth)
                    }
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
                self.email = ""
            }
        }
        
    }
    
}
