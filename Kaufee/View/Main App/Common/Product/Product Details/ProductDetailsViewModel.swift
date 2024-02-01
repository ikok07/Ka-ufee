//
//  ProductDetailsViewModel.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI
import Observation
import iOS_Backend_SDK


extension ProductDetailsMainView {
    
    @Observable final class ViewModel {
        
        var product: BusinessProduct?
        var productImage: Image?
        var productName: String = .init()
        var productDescription: String = .init()
        var productPrice: String = .init()
        var productCurrency: Currency = .bgn
        
        var validation: [Bool] = Array(repeating: true, count: 3)
        
        @MainActor
        func updateProduct(businessId: String) async -> BusinessProduct? {
            var newProduct: BusinessProduct?
            print(self.productCurrency.rawValue)
            await Backend.shared.updateProduct(
                userId: AccountManager.shared.user?._id.stringValue ?? "",
                businessId: businessId,
                productId: self.product?._id ?? "",
                token: AccountManager.shared.user?.token ?? "",
                name: self.productName,
                description: self.productDescription,
                price: Double(self.productPrice) ?? 0,
                currency: self.productCurrency.rawValue,
                image: self.productImage
            ) { result in
                    switch result {
                    case .success(let response):
                        if let backendProduct = response.data?.product {
                            newProduct = backendProduct
                            UXComponents.shared.showMsg(type: .success, text: "Successfully updated product!")
                        }
                    case .failure(let error):
                        UXComponents.shared.showMsg(
                            type: .error,
                            text: error.localizedDescription
                        )
                    }
            }
            return newProduct
        }
        
        @MainActor
        func reloadProduct(businessId: String) async -> BusinessProduct? {
            var newProduct: BusinessProduct?
            await Backend.shared.getSingleProduct(
                userId: AccountManager.shared.user?._id.stringValue ?? "",
                businessId: businessId,
                productId: self.product?._id ?? "",
                token: AccountManager.shared.user?.token ?? ""
            ) { result in
                switch result {
                case .success(let response):
                    if let backendProduct = response.data?.product {
                        newProduct = backendProduct
                    }
                case .failure(let error):
                    UXComponents.shared.showMsg(
                        type: .error,
                        text: error.localizedDescription
                    )
                }
            }
            return newProduct
        }
        
        func updateButtonActive() -> Bool {
            return (self.productName != self.product?.name || self.productDescription != self.product?.description || Double(self.productPrice) ?? 0 != self.product?.price || self.productCurrency.rawValue != self.product?.currency || self.productImage != nil) && self.validation == Array(repeating: true, count: 3)
        }
        
    }
    
}
