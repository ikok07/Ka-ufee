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
    
    @Binding var business: Business
    
    @State private var viewIsLoaded: Bool = false
    
    var body: some View {
        ScrollView {
            if accManager.user?.role == "business" {
                OverlayPhotoPickerView(
                    image: $viewModel.businessImage,
                    photoUrl: business.photo
                )
            } else {
                OverlayAsyncImageView(photoUrl: business.photo)
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
        .onAppear {
            if !self.viewIsLoaded {
                self.updateViewModel()
                self.viewIsLoaded = true
            }
        }
        .onChange(of: viewModel.businessProducts, { _, newProducts in
            self.business.products = newProducts
        })
        .toolbar {
            if accManager.user?.role == "business" {
                Button("Update") {
                    Task {
                        guard let newBusiness = await viewModel.updateBusiness() else {
                            return
                        }
                        
                        self.business = newBusiness
                        self.updateViewModel()
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
                self.updateViewModel()
                return
            }
            self.business = newBusiness
            self.updateViewModel()
        })
    }
    
    func updateViewModel() {
        viewModel.business = self.business
        viewModel.businessName = self.business.name
        viewModel.businessDescription = self.business.description
        viewModel.businessProducts = self.business.products
        viewModel.businessCreationDate = self.business.metadata.realCreationDate
    }
}

#Preview {
    NavigationStack {
        BusinessDetailsMainView(business: .constant(K.Template.business))
            .environment(AccountManager.shared)
    }
}
