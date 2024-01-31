//
//  BusinessDetailsViewModel.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import Observation
import iOS_Backend_SDK
import PhotosUI

extension BusinessDetailsMainView {
    
    @Observable final class ViewModel {
        
        var loading: Bool = false
        
        var business: Business?
        var businessImage: Image?
        var businessName: String = .init()
        var businessDescription: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore"
        var businessProducts: [BusinessProduct] = []
        var businessCreationDate: Date = .now
        
        @MainActor
        func reloadBusiness() async -> Business? {
            var newBusiness: Business?
            
            self.loading = true
            await Backend.shared.getSingleBusiness(id: self.business?._id ?? "", token: AccountManager.shared.user?.token ?? "") { result in
                switch result {
                case .success(let response):
                    newBusiness = response.data?.business
                case .failure(let error):
                    UXComponents.shared.showMsg(
                        type: .error,
                        text: error.localizedDescription
                    )
                }
            }
            self.loading = false
            return newBusiness
        }
        
        @MainActor
        func updateBusiness() async -> Business? {
            var newBusiness: Business?
            UXComponents.shared.showLoader(text: "Updating business...")
            await Backend.shared.updateBusiness(
                name: self.businessName,
                description: self.businessDescription,
                image: self.businessImage,
                userId: AccountManager.shared.user?.token ?? "",
                businessId: self.business?._id ?? "",
                token: AccountManager.shared.user?.token ?? ""
            ) { result in
                switch result {
                case .success(let response):
                    UXComponents.shared.showMsg(type: .success, text: "Successfully updated business!")
                    self.businessImage = nil
                    newBusiness = response.data?.business
                case .failure(let error):
                    UXComponents.shared.showMsg(
                        type: .error,
                        text: error.localizedDescription
                    )
                }
            }
            UXComponents.shared.showWholeScreenLoader = false
            return newBusiness
        }
        
        @MainActor
        func deleteProduct(at offsets: IndexSet) async {
            
            if let index = offsets.first {
                let productToDelete = self.businessProducts[index]
                await Backend.shared.deleteProduct(
                    userId: AccountManager.shared.user?._id.stringValue ?? "",
                    businessId: self.business?._id ?? "",
                    productId: productToDelete._id,
                    token: AccountManager.shared.user?.token ?? ""
                ) { result in
                    switch result {
                    case .success(let response):
                        self.businessProducts.remove(at: index)
                    case .failure(let error):
                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                    }
                }
            }
            
        }
        
        func updateButtonActive() -> Bool {
            if let business {
                return self.businessName != business.name || self.businessDescription != business.description || self.businessImage != nil
            } else {
                return false
            }
        }
        
    }
    
}
