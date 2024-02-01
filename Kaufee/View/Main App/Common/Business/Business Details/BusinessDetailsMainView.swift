//
//  BusinessDetailsMainView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import iOS_Backend_SDK
import PhotosUI

struct BusinessDetailsMainView: View {
    
    @State private var viewModel = ViewModel()
    @Environment(AccountManager.self) private var accManager
    @Environment(NavigationManager.self) private var navManager
    
    @Binding var business: Business
    
    @State private var viewIsLoaded: Bool = false
    
    var body: some View {
        ScrollView {
            if accManager.user?.role == "business" {
                OverlayPhotoPickerView(
                    image: $viewModel.businessImage,
                    photoUrl: viewModel.business?.photo ?? "https://"
                )
            } else {
                OverlayAsyncImageView(photoUrl: viewModel.business?.photo ?? "https://")
            }

            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.clear)
                    .background(Color.background)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.1), radius: 12.5, x: 0, y: -20)
                
                BusinessCreatorOverlayView()
                    .environment(viewModel)
            }
            .offset(y: -40)
        }
        .navigationTitle("Business details")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: viewModel.loading)
        .animation(.default, value: viewModel.updateButtonActive())
        .animation(.default, value: viewModel.businessProducts)
        .onAppear {
            if !self.viewIsLoaded {
                self.updateData(business: self.business)
                self.viewIsLoaded = true
            }
        }
        .onChange(of: viewModel.business, { _, newBusiness in
            if let newBusiness {
                self.updateData(business: newBusiness)
            }
        })
        .toolbar {
            if accManager.user?.role == "business" {
                Button("Update") {
                    Task {
                        guard let newBusiness = await viewModel.updateBusiness() else {
                            return
                        }
                        
                        self.business = newBusiness
                        self.updateData(business: newBusiness)
                    }
                }
                .fontWeight(.bold)
                .disabled(!viewModel.updateButtonActive())
            }
        }
        .refreshable(action: {
            guard let newBusiness = await viewModel.reloadBusiness() else {
                UXComponents.shared.showMsg(
                    type: .error,
                    text: CustomError.couldNotConnectToAPI.localizedDescription
                )
                return
            }
            self.updateData(business: newBusiness)
        })
    }
    
    func updateData(business: Business) {
        self.business = business
        viewModel.business = business
        viewModel.businessName = business.name
        viewModel.businessDescription = business.description
        viewModel.businessProducts = business.products
        viewModel.businessCreationDate = business.metadata.realCreationDate
    }
}

#Preview {
    NavigationStack {
        BusinessDetailsMainView(business: .constant(K.Template.business))
            .environment(AccountManager.shared)
            .environment(NavigationManager.shared)
    }
}
