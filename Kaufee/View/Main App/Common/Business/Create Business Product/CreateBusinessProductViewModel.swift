//
//  CreateBusinessProductViewModel.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI
import iOS_Backend_SDK
import Observation

extension CreateBusinessProductSheet {
    
    @Observable final class ViewModel {
        
        var image: Image?
        var name: String = .init()
        var description: String = .init()
        var price: String = .init()
        var currency: Currency = .bgn
        
        
        var validation: [Bool] = Array(repeating: false, count: 3)
        
        func createButtonActive() -> Bool {
            return validation == Array(repeating: true, count: 3) || self.image != nil
        }
        
        @MainActor
        func createProduct(businessId: String) async -> BusinessProduct? {
            var newProduct: BusinessProduct?
            await Backend.shared.createProduct(
                name: self.name,
                description: self.description,
                price: self.price,
                currency: self.currency.rawValue,
                image: self.image,
                userId: AccountManager.shared.user?._id.stringValue ?? "",
                businessId: businessId,
                token: AccountManager.shared.user?.token ?? "")
            { result in
                switch result {
                case .success(let response):
                    newProduct = response.data?.product
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
            return newProduct
        }
        
    }
    
}
