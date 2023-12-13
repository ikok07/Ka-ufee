//
//  EmailConfirmationCompleteView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.12.23.
//

import SwiftUI
import RealmSwift
import iOS_Backend_SDK

struct EmailConfirmationCompleteView: View {
    
    @Environment(NavigationManager.self) private var navManager
    
    @ObservedResults(LoginStatus.self) private var loginStatusResults
    @ObservedResults(User.self) private var userResults
    
    var body: some View {
        VStack(spacing: 30) {
            BeforeAuthHeadingView(icon: "shield.lefthalf.filled.badge.checkmark", heading: "Authentication successfull", mainHeadingWord: "", subheadline: "Your identity is now verified")
            
            DefaultButton(text: "Continue") {
                Task {
                    await finishEmailVerification()
                }
            }
            Spacer()
        }
        .navigationTitle("Confirmation")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .padding(.top)
    }
    
    func finishEmailVerification() async {
        if navManager.hasSetup {
            await Backend.shared.getUserDetails(userId: userResults.first?._id.stringValue ?? "") { result in
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
    
    func saveNewLoginStatus(hasDetails: Bool) async {
        if let loginStatus = loginStatusResults.first?.thaw() {
            DB.shared.update {
                loginStatus.isLoggedIn = true
                loginStatus.hasDetails = hasDetails
            }
        }
    }
}

#Preview {
    EmailConfirmationCompleteView()
        .environment(NavigationManager())
}
