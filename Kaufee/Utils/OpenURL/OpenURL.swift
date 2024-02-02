//
//  OpenURL.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import Foundation
import SwiftMacros
import GoogleSignIn
import StripePaymentsUI


final class OpenURL {
    
    static var main = OpenURL()
    private init() {}
    
    var email: String = ""
    var appSecurityTokenId: String?
    
    func open(url: URL) async {
        let stripeHandled = StripeAPI.handleURLCallback(with: url)
        guard !stripeHandled else {
            return
        }
        
        await handleBackendUrl(url: url)
    }
    
    func handleBackendUrl(url: URL) async {
        if url.pathComponents.count > 2 {
            let token = url.pathComponents[2]
           
            switch url.host() {
            case "email":
                await confirmEmail(token: token, isTwoFa: false, appSecurityTokenId: self.appSecurityTokenId)
            case "login":
                await confirmEmail(token: token, isTwoFa: true, appSecurityTokenId: self.appSecurityTokenId)
            case "password":
                NavigationManager.shared.navigate(to: .forgotPasswordEmailConfirmed(token: token), path: .beforeAuth)
            default:
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
