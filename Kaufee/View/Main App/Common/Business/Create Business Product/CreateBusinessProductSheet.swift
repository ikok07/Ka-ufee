//
//  CreateBusinessProductSheet.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI
import iOS_Backend_SDK

struct CreateBusinessProductSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    @Binding var business: Business?
    
    @State private var priceError: (isAvailable: Bool, text: String) = (false, "")
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    List {
                        CreateItemPhotoPickerView(
                            emptyResultText: "Click to upload image\nof your product",
                            geometry: geometry,
                            image: $viewModel.image
                        )
                        
                        ListInputField(
                                       label: "Name",
                                       placeholder: "Product name",
                                       text: $viewModel.name,
                                       validation: $viewModel.validation[0]
                        )
                        .validationType(.general)
                        .padding(.top)
                        
                        ListInputField(
                                       label: "Info",
                                       placeholder: "Product description",
                                       text: $viewModel.description,
                                       validation: $viewModel.validation[1]
                        )
                        .validationType(.general)
                        .fieldLineLimit(5, reservesSpace: true)
                        
                        ListRowView(
                            label: "Price",
                            textColor: priceError.isAvailable ? .red : .label
                        ) {
                            HStack {
                                PlainTextField(
                                    placeholder: "Product price",
                                    text: $viewModel.price,
                                    validation: $viewModel.validation[2],
                                    error: $priceError
                                )
                                .validationType(.general)
                                .keyboardType(.decimalPad)
                                
                                Spacer()
                                
                                Picker("", selection: $viewModel.currency) {
                                    ForEach(Currency.allCases, id: \.self) { currency in
                                        Text(currency.rawValue.uppercased())
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Create product")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel", action: { dismiss() })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Create") {
                            Task {
                                guard let newProduct = await viewModel.createProduct(
                                    businessId: self.business?._id ?? ""
                                ) else {
                                    return
                                }
                                
                                self.business?.products.append(newProduct)
                                dismiss()
                            }
                        }
                        .fontWeight(.bold)
                        .disabled(!viewModel.createButtonActive())
                    }
                }
                .animation(.default, value: viewModel.createButtonActive())
            }
        }
    }
}

#Preview {
    CreateBusinessProductSheet(business: .constant(nil))
}
