//
//  ProfileSettingsView.swift
//  Kaufee
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
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        List {
            ProfileSettingsUserView(imageUrl: accManager.user?.photo ?? "", name: userResults.first?.name ?? "No username", email: userResults.first?.email ?? "No email", localImage: viewModel.image, imageItem: $imageItem)
            
            ListProgressView(isActive: viewModel.isLoading)
            
            Section {
                ListInputField(label: "Role", placeholder: "Your role", isDisabled: true, text: $viewModel.userType, validation: $viewModel.validation[0])
                
                ListInputField(label: "Email", placeholder: "Your email", isDisabled: true, text: $viewModel.email, validation: $viewModel.validation[0])
                
                ListInputField(label: "Name", placeholder: "Required field", isDisabled: false, text: $viewModel.name, validation: $viewModel.validation[1])
                    .validationType(.general)
            }
            
//            Button("Delete profile", role: .destructive) {
//                UXComponents.shared.showLoader(text: "Delete profile" )
//                self.showDeleteAlert = true
//            }
//            .alert("Are you sure?", isPresented: $showDeleteAlert, presenting: DeleteProfileOption.self) { option in
//                Button("Delete", role: .destructive) {
//                    Task {
//                        await accManager.deleteUser()
//                        UXComponents.shared.showWholeScreenLoader = false
//                    }
//                }
//                Button("Cancel", role: .cancel) {
//                    UXComponents.shared.showWholeScreenLoader = false
//                }
//            } message: { option in
//                Text("All of your information will be deleted and your account will be permanently closed.")
//            }
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
            if let user = userResults.first {
                viewModel.userType = user.role.capitalizingFirstLetter()
                viewModel.name = user.name
                viewModel.email = user.email
            }
        }
        .onChange(of: self.imageItem) { _, newItem in
            Task {
                await viewModel.convertImageItem(newItem)
            }
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
