//
//  AccountManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift
import Observation
import iOS_Backend_SDK
import UIKit

@Observable final class AccountManager {
    
    static let shared = AccountManager()
    private init() {}

    var user: User? {
        get {
            let user: User? = DB.shared.fetch()?.first
            return user?.thaw()
        }
    }
    
    var loginStatus: LoginStatus? {
        get {
            let status: LoginStatus? = DB.shared.fetch()?.first
            return status?.thaw()
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
}
