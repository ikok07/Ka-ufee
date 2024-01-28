//
//  AccountManager.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift
import Observation
import iOS_Backend_SDK
import UIKit

@Observable final class AccountManager {
    
    private var notificationToken: NotificationToken?
    static let shared = AccountManager()
    private init() {}
    
    var userLoaded: Bool = false

    var user: User? {
        get {
            let user: User? = DB.shared.fetch()?.first
            return user?.thaw()
        }
    }
    
    var loginStatus : LoginStatus? {
        get {
            let status: LoginStatus? = DB.shared.fetch()?.first
            return status?.thaw()
        }
    }
    
    @MainActor
    func reloadUser() async {
        do {
            self.userLoaded = false
            try await AccountManager.shared.downloadLatestUser()
            self.userLoaded = true
            print("User reloaded")
        } catch {
            print("Failed to reload user: \(error)")
            UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
            if let user = self.user {
                do {
                    try DB.shared.delete(user)
                    self.loginStatus?.logOut()
                } catch {
                    print("Failed to delete user: \(error)")
                }
            } else {
                self.loginStatus?.logOut()
            }
        }
    }
    
    static func convertBackendUser(_ backendUser: BackendUser, token: String?) -> User {
        return User(
            _id: try! ObjectId(string: backendUser._id),
            oauthProviderUserId: backendUser.oauthProviderUserId,
            token: token ?? "",
            name: backendUser.name,
            email: backendUser.email,
            photo: backendUser.photo,
            role: backendUser.role,
            oauthProvider: backendUser.oauthProvider
        )
    }
}
