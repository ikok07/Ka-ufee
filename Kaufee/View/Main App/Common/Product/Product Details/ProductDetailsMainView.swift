//
//  ProductDetailsMainView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI
import iOS_Backend_SDK

struct ProductDetailsMainView: View {
    
    @State private var viewModel = ViewModel()
    @Environment(AccountManager.self) private var accManager
    
    let businessId: String
    
    @Binding var product: BusinessProduct
    
    var body: some View {
        ScrollView {
            if accManager.user?.role == "business" {
                OverlayPhotoPickerView(
                    image: $viewModel.productImage,
                    photoUrl: product.photo
                )
            } else {
                OverlayAsyncImageView(photoUrl: product.photo)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.clear)
                    .background(Color.background)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.1), radius: 12.5, x: 0, y: -20)
                
                ProductOverlayView()
                    .environment(viewModel)
            }
            .offset(y: -40)
        }
        .animation(.default, value: viewModel.updateButtonActive())
        .onAppear {
            updateViewModel()
        }
        .toolbar {
            if accManager.user?.role == "business" {
                Button("Update") {
                    Task {
                        guard let newProduct = await viewModel.updateProduct(businessId: self.businessId) else {
                            return
                        }
                        self.product = newProduct
                        self.updateViewModel()
                    }
                }
                .fontWeight(.bold)
                .disabled(!viewModel.updateButtonActive())
            }
        }
        .refreshable {
            await Task {
                guard let newProduct = await viewModel.reloadProduct(businessId: self.businessId) else {
                    UXComponents.shared.showMsg(
                        type: .error,
                        text: CustomError.couldNotConnectToAPI.localizedDescription
                    )
                    self.updateViewModel()
                    return
                }
                
                self.product = newProduct
                self.updateViewModel()
            }.value
        }
    }
    
    func updateViewModel() {
        self.viewModel.product = self.product
        self.viewModel.productName = self.product.name
        self.viewModel.productDescription = self.product.description
        self.viewModel.productPrice = String(self.product.price)
        self.viewModel.productCurrency = Currency(rawValue: self.product.currency) ?? .bgn
    }
}

#Preview {
    ProductDetailsMainView(businessId: "65b2c541bccb5be91e0d7d77", product: .constant(K.Template.businessProduct))
        .environment(AccountManager.shared)
}
