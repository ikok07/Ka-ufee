//
//  OpenURL.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import Foundation
import SwiftMacros


final class OpenURL {
    
    static var main = OpenURL()
    private init() {}
    
    var email: String = ""
    
    func open(url: URL) async {
        if url.pathComponents.count > 2 {
            let token = url.pathComponents[2]
           
            switch url.host() {
            case "email":
                await confirmEmail(token: token, isTwoFa: false)
            case "login":
                await confirmEmail(token: token, isTwoFa: true)
            case "password":
                NavigationManager.shared.navigate(to: .forgotPasswordEmailConfirmed(token: token), path: .beforeAuth)
            default:
                print("URL IS NOT RECOGNISED")
                return
            }
        }
    }
}
