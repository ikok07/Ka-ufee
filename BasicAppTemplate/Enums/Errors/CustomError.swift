//
//  CustomError.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 16.12.23.
//

import Foundation

enum CustomError: LocalizedError, Error {
    case fromText(text: String)
    case couldNotConnectToAPI
    case signInWithAppleFailed
    case noUserAvailable
    case saveUserDetailsFailed
    case cannotLogOut
    
    var errorDescription: String? {
        switch self {
        case .fromText(let text):
            text
        case .couldNotConnectToAPI:
            "There was an error connecting to the server. Please try again!"
        case .signInWithAppleFailed:
            "An error occurred while signing in with Apple"
        case .noUserAvailable:
            "There is no user available. Please log in again!"
        case .saveUserDetailsFailed:
            "Settings could not be saved"
        case .cannotLogOut:
            "We couldn't log you out. Please try again!"
        }
    }
}
