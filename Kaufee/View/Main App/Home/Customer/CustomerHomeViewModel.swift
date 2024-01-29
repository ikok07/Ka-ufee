//
//  CustomerHomeViewModel.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation
import Observation
import iOS_Backend_SDK

extension CustomerHomeView {
    
    @Observable final class ViewModel {
        
        var loading: Bool = true
        
        var searchText: String = .init()
        var showedBusinesses: [Business] = []
        
        func getAllBusinesses(token: String?) async {
            if let token {
                await Backend.shared.getAllBusinesses(token: token) { result in
                    switch result {
                    case .success(let response):
                        if let businesses = response.data?.businesses {
                            self.showedBusinesses = []
                            for business in businesses {
                                self.showedBusinesses.append(business)
                            }
                        }
                    case .failure(let error):
                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    }
                }
            }
            self.loading = false
        }
        
    }
    
}
