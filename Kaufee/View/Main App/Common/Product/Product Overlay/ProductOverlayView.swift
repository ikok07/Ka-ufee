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
    
    @State private var tempValidation: [Bool] = Array(repeating: false, count: 2)
    @State private var priceError: (isAvailable: Bool, text: String) = (false, "")
    
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
                validation: $viewModel.validation,
                detailsPageType: .product(price: $viewModel.productPrice, currency: $viewModel.productCurrency),
                listHeight: 300
            ) {
                ListRowView(
                    label: "Price",
                    textColor: priceError.isAvailable ? .red : .label
                ) {
                    HStack {
                        PlainTextField(
                            placeholder: "Product price",
                            text: $viewModel.productPrice,
                            validation: $viewModel.validation[2],
                            error: $priceError
                        )
                        .validationType(.general)
                        .keyboardType(.decimalPad)
                        
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
        .onChange(of: self.tempValidation, { oldValue, newValue in
            print(viewModel.validation)
            self.viewModel.validation[0] = newValue[0]
            self.viewModel.validation[1] = newValue[1]
        })
        .onChange(of: viewModel.validation) { oldValue, newValue in
            print(newValue)
        }
    }
}

#Preview {
    ProductOverlayView()
        .environment(ProductDetailsMainView.ViewModel())
        .environment(AccountManager.shared)
}
