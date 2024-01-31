//
//  BusinessHomeViewModel.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI
import Observation
import iOS_Backend_SDK

extension BusinessHomeView {
    
    @Observable final class ViewModel {
        
        var loading: Bool = true
        
        var searchText: String = .init()
        var userBusinesses: [Business] = []
        
        @MainActor
        func getAllBusinesses(userId: String?, token: String?) async {
            if let userId, let token {
                await Backend.shared.getAllBusinessesForSpecificUser(userId: userId, token: token) { result in
                    switch result {
                    case .success(let response):
                        if let businesses = response.data?.businesses {
                            self.userBusinesses = []
                            for business in businesses {
                                self.userBusinesses.append(business)
                            }
                        }
                    case .failure(let error):
                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    }
                }
            } else {
                UXComponents.shared.showMsg(type: .error, text: CustomError.noUserAvailable.localizedDescription)
            }
        }
        
        func deleteBusiness(at offsets: IndexSet, authToken: String?) async {
            if let index = offsets.first {
                let businessToDelete = self.userBusinesses[index]
                await Backend.shared.deleteBusiness(businessId: businessToDelete._id, token: authToken ?? "") { result in
                    switch result {
                    case .success(_):
                        self.userBusinesses.remove(at: index)
                    case .failure(let error):
                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    }
                }
            } else {
                UXComponents.shared.showMsg(type: .error, text: CustomError.couldNotConnectToAPI.localizedDescription)
            }
        }
    }
    
}
