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
                
            
            Section {
                SettingsInputField(label: "Email", placeholder: "Your email", isDisabled: true, text: $viewModel.email)
                
                SettingsInputField(label: "Name", placeholder: "Your name", isDisabled: false, text: $viewModel.name)
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            let buttonDisabled = !viewModel.saveButtonActive(user: accManager.user)
            Button("Save") {
                if let user = userResults.first {
                    Task { await viewModel.saveDetails(user: user) }
                }
            }
            .fontWeight(.semibold)
            .disabled(buttonDisabled)
            .animation(.default, value: buttonDisabled)
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
    }
}

#Preview {
    NavigationStack {
        ProfileSettingsView()
            .environment(AccountManager())
    }
}
