//
//  AccountManager- BeforeAuth.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import UIKit
import RealmSwift
import iOS_Backend_SDK
import AuthenticationServices

extension AccountManager {
    
    static func createNewLoginStatus() {
        let loginStatus = LoginStatus(isLoggedIn: false, hasDetails: false)
        do {
            try DB.shared.save(loginStatus)
        } catch {
            print("Could not create new login details: \(error)")
        }
    }
    
    @MainActor func saveNewLoginStatus(hasDetails: Bool) async {
        DB.shared.update {
            self.loginStatus?.isLoggedIn = true
            self.loginStatus?.hasDetails = hasDetails
        }
    }
    
    @MainActor func finishEmailVerification() async {
        self.userLoaded = true
        if NavigationManager.shared.hasSetup {
            do {
                if NavigationManager.shared.hasSetup {
                    try await self.downloadUserDetails()
                }
                await saveNewLoginStatus(hasDetails: true)
            } catch {
                print(error)
                await saveNewLoginStatus(hasDetails: false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                NavigationManager.shared.beforeAuthPath = .init()
            }
        } else {
            await saveNewLoginStatus(hasDetails: false)
            NavigationManager.shared.navigate(to: .tabViewManager, path: .beforeAuth)
        }
    }
    
    @MainActor
    func signInWithApple(result: Result<ASAuthorization, Error>, nonce: Nonce) async {
        await Backend.shared.completeSignInWithApple(result: result, nonce: nonce) { backendResult in
            switch backendResult {
            case .success(let response):
                guard let backendUser = response.data?.user else {
                    UXComponents.shared.showMsg(type: .error, text: CustomError.signInWithAppleFailed.localizedDescription)
                    UXComponents.shared.showWholeScreenLoader = false
                    return
                }
                
                let user = User(_id: try! ObjectId(string: backendUser._id), oauthProviderUserId: backendUser.oauthProviderUserId, token: response.token ?? "", name: backendUser.name, email: backendUser.email, photo: backendUser.photo, role: backendUser.role, oauthProvider: backendUser.oauthProvider)
                
                do {
                    try DB.shared.save(user, shouldBeOnlyOne: true, ofType: User.self)
                    await AccountManager.shared.finishEmailVerification()
                    UXComponents.shared.showWholeScreenLoader = false
                } catch {
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    UXComponents.shared.showWholeScreenLoader = false
                }
            case .failure(let error):
                UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                UXComponents.shared.showWholeScreenLoader = false
            }
        }
    }
    
    @MainActor
    func signInWithGoogle() async {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        UXComponents.shared.showLoader(text: "Signing in...")
        await Backend.shared.handleSignInWithGoogle(
            rootVC: presentingViewController) { result in
                switch result {
                case .success(let response):
                    if let backendUser = response.data?.user {
                        let user = AccountManager.convertBackendUser(backendUser, token: response.token)
                        
                        do {
                            try DB.shared.save(user, shouldBeOnlyOne: true, ofType: User.self)
                            await self.finishEmailVerification()
                        } catch {
                            UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
        UXComponents.shared.showWholeScreenLoader = false
    }
    
}
