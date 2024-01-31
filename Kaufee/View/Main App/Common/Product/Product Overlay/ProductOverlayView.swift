//
//  ProductOverlayView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI
import iOS_Backend_SDK

struct ProductOverlayView: View {
    
    @Environment(AccountManager.self) private var accManager
    @Environment(ProductDetailsMainView.ViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        
        VStack {
            
            OverlayHeadingView(
                name: viewModel.product?.name ?? "",
                creationDate: viewModel.product?.metadata.realCreationDate ?? .now
            )
            .padding(.horizontal)
            .padding(.top, 20)
            
            DetailsPageFieldsView(
                name: $viewModel.productName,
                description: $viewModel.productDescription,
                detailsPageType: .product(price: $viewModel.productPrice, currency: $viewModel.productCurrency),
                listHeight: 300
            ) {
                ListRowView(label: "Price") {
                    HStack {
                        TextField("Product price", text: $viewModel.productPrice)
                            .keyboardType(.asciiCapableNumberPad)
                        
                        Spacer()
                        
                        Picker("", selection: $viewModel.productCurrency) {
                            ForEach(Currency.allCases, id: \.self) { currency in
                                Text(currency.rawValue.uppercased())
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProductOverlayView()
        .environment(ProductDetailsMainView.ViewModel())
        .environment(AccountManager.shared)
}
