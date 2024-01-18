//
//  CustomError.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 16.12.23.
//

import Foundation

enum CustomError: String, Error {
    case signInWithAppleFailed = "An error occurred while signing in with Apple"
    case noUserAvailable = "There is no user available. Please log in again!"
    case saveUserDetailsFailed = "Settings could not be saved"
    case cannotLogOut = "We couldn't log you out. Please try again!"
}
