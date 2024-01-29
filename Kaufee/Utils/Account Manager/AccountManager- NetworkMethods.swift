//
//  AccountManager- DownloadMethods.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import Foundation
import iOS_Backend_SDK
import RealmSwift

extension AccountManager {
    
    @MainActor
    func downloadLatestUser() async throws {
        var throwError: Error?
        await Backend.shared.getUser(authToken: self.user?.token ?? "") { result in
            switch result {
            case .success(let response):
                if let backendUser = response.data {
                    do {
                        let newUser = Self.convertBackendUser(backendUser, token: self.user?.token)
                        try DB.shared.save(newUser)
//                        self.user = newUser
                    } catch {
                        throwError = error
                    }
                }
            case .failure(let error):
                throwError = error
            }
        }
        if let throwError {
            throw throwError
        }
    }
    
    @MainActor
    func downloadUserDetails() async throws {
        if let user {
            var customError: CustomError?
            await Backend.shared.getUserDetails(userId: user._id.stringValue, authToken: user.token ?? "") { result in
                switch result {
                case .success(let response):
                    if let backendUserDetails = response.data?.userDetails {
                        DB.shared.update {
                            let userDetails = UserDetails(_id: try! ObjectId(string: backendUserDetails._id), userId: backendUserDetails.userId)
                            user.details = userDetails
                        }
                    }
                case .failure(let error):
                    customError = CustomError.fromText(text: error.localizedDescription)
                }
            }
            if let customError {
                throw customError
            }
        } else {
            throw CustomError.noUserAvailable
        }
    }
    
    @MainActor
    func logout(force: Bool = false) async {
        
        guard !force else {
            if let user {
                try? DB.shared.delete(user)
            }
            loginStatus?.logOut()
            return
        }
        
        if let user {
            await Backend.shared.logOut(userToken: user.token ?? "", deviceToken: NotificationManager.shared.deviceToken) { result in
                switch result {
                case .success(_):
                    loginStatus?.logOut()
                    
                    do {
                        try DB.shared.delete(user)
                    } catch {
                        UXComponents.shared.showMsg(type: .error, text: CustomError.cannotLogOut.localizedDescription)
                    }
                    
                    NavigationManager.shared.clearPaths()
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
        } else {
            UXComponents.shared.showMsg(type: .error, text: CustomError.cannotLogOut.localizedDescription)
        }
    }
    
    @MainActor
    func deleteUser() async {
        if let user {
            let backendUser: BackendUser = .init(
                _id: user._id.stringValue,
                oauthProviderUserId: user.oauthProviderUserId,
                token: user.token,
                name: user.name,
                email: user.email,
                photo: user.photo,
                role: user.role,
                oauthProvider: user.oauthProvider
            )
            
            await Backend.shared.deleteUser(backendUser) { result in
                switch result {
                case .success(_):
                    UXComponents.shared.showAccountDeleted = true
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
        }
    }
    
}
