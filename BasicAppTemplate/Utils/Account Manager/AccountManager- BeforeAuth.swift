//
//  AccountManager- BeforeAuth.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import Foundation
import RealmSwift
import iOS_Backend_SDK

extension AccountManager {
    
    static func getLoginStatus() -> LoginStatus? {
        let results: Results<LoginStatus>? = DB.shared.fetch()
        guard let results else {
            return nil
        }
        
        if let loginStatus = results.first {
            return loginStatus
        }
        
        return nil
    }
    
    static func createNewLoginStatus() {
        let loginStatus = LoginStatus(isLoggedIn: false, hasDetails: false)
        DB.shared.save(loginStatus)
    }
    
    @MainActor func saveNewLoginStatus(hasDetails: Bool) async {
        let loginStatusResults: Results<LoginStatus>? = DB.shared.fetch()
        if let loginStatus = loginStatusResults?.first?.thaw() {
            DB.shared.update {
                loginStatus.isLoggedIn = true
                loginStatus.hasDetails = hasDetails
            }
        }
    }
    
    @MainActor func finishEmailVerification() async {
        if NavigationManager.shared.hasSetup {
            let userResults: Results<User>? = DB.shared.fetch()
            await Backend.shared.getUserDetails(userId: userResults?.first?._id.stringValue ?? "", authToken: userResults?.first?.token ?? "") { result in
                switch result {
                case .success(let response):
                    let userResults: Results<User>? = DB.shared.fetch()
                    if let backendUserDetails = response.data?.userDetails, let user = userResults?.first?.thaw() {
                        DB.shared.update {
                            let userDetails = UserDetails(_id: try! ObjectId(string: backendUserDetails._id), userId: backendUserDetails.userId)
                            user.details = userDetails
                        }
                        AccountManager.shared.user = user
                        await saveNewLoginStatus(hasDetails: true)
                    } else {
                        await saveNewLoginStatus(hasDetails: false)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        NavigationManager.shared.beforeAuthPath = .init()
                    }
                case .failure(let error):
                    print(error)
                    await saveNewLoginStatus(hasDetails: false)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        NavigationManager.shared.beforeAuthPath = .init()
                    }
                }
            }
        } else {
            await saveNewLoginStatus(hasDetails: false)
            NavigationManager.shared.navigate(to: .tabViewManager, path: .beforeAuth)
        }
    }
    
}
