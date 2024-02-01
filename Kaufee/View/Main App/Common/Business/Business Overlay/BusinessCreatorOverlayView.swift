//
//  BusinessCreatorOverlayView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import iOS_Backend_SDK

struct BusinessCreatorOverlayView: View {
    
    @Environment(BusinessDetailsMainView.ViewModel.self) private var viewModel
    @Environment(NavigationManager.self) private var navManager
    @Environment(AccountManager.self) private var accManager
    
    @State private var createProductSheetActive = false
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        
        VStack {
            OverlayHeadingView(
                name: viewModel.business?.name ?? "No name",
                creationDate: viewModel.business?.metadata.realCreationDate ?? .now
            )
                .padding(.horizontal)
                .padding(.top, 20)
            
            DetailsPageFieldsView(
                name: $viewModel.businessName,
                description: $viewModel.businessDescription,
                validation: $viewModel.validation
            ) {}
            
            VStack {
                HStack {
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                    if accManager.user?.role == "business" {
                        Button {
                            self.createProductSheetActive = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.accent)
                                .font(.title3)
                                .fontWeight(.medium)
                        }

                    }
                }
                .padding()
                
                Spacer()
                
                if viewModel.loading {
                    LoadingView(text: "Loading products...")
                } else if viewModel.businessProducts.isEmpty {
                    NoResultView(
                        icon: "cart.badge.questionmark",
                        headline: "No products found",
                        subheadline: "There are no products\nfor this business"
                    )
                } else {
                    List {
                        ForEach(viewModel.businessProducts, id: \.self) { product in
                            let productIndex = viewModel.businessProducts.firstIndex(of: product)
                            Button {
                                if let productIndex {
                                    navManager.navigate(to: .ProductDetails(
                                        businessId: viewModel.business?._id ?? "",
                                        product: EquatableBinding(
                                            wrappedValue: $viewModel.businessProducts[productIndex])),
                                            path: .home
                                    )
                                }
                            } label: {
                                ProductCardView(product: product)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            Task {
                                await viewModel.deleteProduct(at: indexSet)
                                viewModel.business?.products = viewModel.businessProducts
                            }
                        })
                    }
                    .listStyle(.plain)
                    .padding(.top, 5)
                    .listRowSpacing(5)
                    .frame(height: 300)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $createProductSheetActive, content: {
            CreateBusinessProductSheet(business: $viewModel.business)
                .presentationDetents([.height(550)])
        })
    }
}

#Preview {
    BusinessCreatorOverlayView()
        .environment(BusinessDetailsMainView.ViewModel())
        .environment(AccountManager.shared)
        .environment(NavigationManager.shared)
}
