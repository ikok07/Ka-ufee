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
        if Navigator.main.navigationManager?.hasSetup ?? false {
            let userResults: Results<User>? = DB.shared.fetch()
            await Backend.shared.getUserDetails(userId: userResults?.first?._id.stringValue ?? "") { result in
                switch result {
                case .success(let response):
                    if let backendUserDetails = response.data?.userDetails {
                        let userDetails = UserDetails(_id: try! ObjectId(string: backendUserDetails._id), userId: backendUserDetails.userId)
                        DB.shared.save(userDetails, shouldBeOnlyOne: true, ofType: UserDetails.self)
                        await saveNewLoginStatus(hasDetails: true)
                    } else {
                        await saveNewLoginStatus(hasDetails: false)
                    }
                case .failure(let error):
                    print(error)
                    await saveNewLoginStatus(hasDetails: false)
                }
            }
        } else {
            await saveNewLoginStatus(hasDetails: false)
            Navigator.main.navigate(to: .tabViewManager, path: .beforeAuth)
        }
    }
    
}
