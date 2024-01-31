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
    @State private var pickerItem: PhotosPickerItem?
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    List {
                        VStack {
                            if let image = viewModel.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width - 30, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                                CreateBusinessEmptyImageFieldView()
                            }
                        }
                        .frame(height: 200)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .overlay {
                            PhotosPicker("", selection: $pickerItem, matching: .images)
                        }
                        .onChange(of: self.pickerItem) { _, newItem in
                            Task {
                                if let loadedImage = try? await newItem?.loadTransferable(type: Image.self) {
                                    viewModel.image = loadedImage
                                }
                            }
                        }
                        
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
