//
//  CreateBusinessView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI
import iOS_Backend_SDK
import PhotosUI

struct CreateBusinessView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var businesses: [Business]
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    List {
                        CreateItemPhotoPickerView(
                            emptyResultText: "Click to upload image\nof your business",
                            geometry: geometry,
                            image: $viewModel.image
                        )
                        
                        ListInputField(
                                       label: "Name",
                                       placeholder: "Business name",
                                       text: $viewModel.name,
                                       validation: $viewModel.validations[0]
                        )
                        .validationType(.general)
                        .padding(.top)
                        
                        ListInputField(
                                       label: "Info",
                                       placeholder: "Business description",
                                       text: $viewModel.description,
                                       validation: $viewModel.validations[1]
                        )
                        .validationType(.general)
                        .fieldLineLimit(5, reservesSpace: true)
                        
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("New business")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        Task {
                            await viewModel.createBusiness(token: AccountManager.shared.user?.token) { response in
                                if let business = response.data?.business {
                                    self.businesses.append(business)
                                }
                                dismiss()
                            }
//                            self.businesses.append(K.Template.business)
//                            dismiss()
                        }
                    }
                    .fontWeight(.bold)
                    .disabled(!viewModel.createButtonActive())
                }
            }
            .animation(.default, value: viewModel.validations)
        }
    }
}

#Preview {
    CreateBusinessView(businesses: .constant([]))
}
