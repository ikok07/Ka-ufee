//
//  ProfileSettingsView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI
import PhotosUI
import RealmSwift

struct ProfileSettingsView: View {
    
    @ObservedResults(User.self) private var userResults
    
    @Environment(AccountManager.self) private var accManager
    @Bindable private var viewModel = ViewModel()
    
    @State private var imageItem: PhotosPickerItem?
    
    var body: some View {
        List {
            ProfileSettingsUserView(imageUrl: accManager.user?.photo ?? "", name: accManager.user?.name ?? "No username", email: accManager.user?.email ?? "No email", localImage: viewModel.image, imageItem: $imageItem)
            
            ListProgressView(isActive: viewModel.isLoading)
            
            Section {
                ListInputField(label: "Email", placeholder: "Your email", isDisabled: true, text: $viewModel.email, validation: $viewModel.validation[0])
                
                ListInputField(label: "Name", placeholder: "Required field", isDisabled: false, text: $viewModel.name, validation: $viewModel.validation[1])
                    .validationType(.general)
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button("Save") {
                Task { await viewModel.saveDetails() }
            }
            .fontWeight(.semibold)
            .disabled(!viewModel.saveButtonActive())
        }
        .onAppear {
            viewModel.name = accManager.user?.name ?? "No username"
            viewModel.email = accManager.user?.email ?? "No email"
        }
        .onChange(of: self.imageItem) { _, newItem in
            Task {
                await viewModel.convertImageItem(newItem)
            }
        }
        .onChange(of: viewModel.validation) { _, newValue in
            print(newValue)
        }
        .animation(.default, value: !viewModel.saveButtonActive())
        .animation(.default, value: !viewModel.isLoading)
    }
}

#Preview {
    NavigationStack {
        ProfileSettingsView()
            .environment(AccountManager.shared)
    }
}
