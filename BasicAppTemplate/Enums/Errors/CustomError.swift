//
//  CustomError.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 16.12.23.
//

import Foundation

enum CustomError: String, Error {
    case NoUserAvailable = "There is no user available. Please log in again!"
}
