//
//  BusinessHomeViewModel.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation

extension BusinessHomeView {
    
    @Observable final class ViewModel {
        
        var loading: Bool = false
        
        var searchText: String = .init()
        var userBusinesses: [Business] = [K.Template.business, K.Template.business, K.Template.business]
        
        
    }
    
}
