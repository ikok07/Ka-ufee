//
//  ProfileSettingsView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI
import PhotosUI

struct ProfileSettingsView: View {
    
    @Environment(AccountManager.self) private var accManager
    @Bindable private var viewModel = ViewModel()
    
    @State private var imageItem: PhotosPickerItem?
    
    var body: some View {
        List {
            ProfileSettingsUserView(imageUrl: accManager.user?.photo ?? "", name: accManager.user?.name ?? "No username", email: accManager.user?.email ?? "No email", localImage: viewModel.image)
                .overlay {
                    PhotosPicker(selection: $imageItem, matching: .images) {
                        HStack {
                            Spacer()
                            Image(systemName: "camera.fill")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                                .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color(uiColor: .systemBackground), lineWidth: 4)
                                }
                        }
                        .frame(width: 75)
                    }
                }
                .onChange(of: self.imageItem) { _, newItem in
                    Task {
                        await viewModel.convertImageItem(newItem)
                    }
                }
            
            Section {
                SettingsInputField(label: "Email", placeholder: "Your email", isDisabled: true, text: $viewModel.email)
                
                SettingsInputField(label: "Name", placeholder: "Your name", isDisabled: false, text: $viewModel.name)
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            let buttonDisabled = !viewModel.saveButtonActive(user: accManager.user)
            Button("Save") {
                Task { await viewModel.saveDetails() }
            }
            .fontWeight(.semibold)
            .disabled(buttonDisabled)
            .animation(.default, value: buttonDisabled)
        }
        .onAppear {
            viewModel.name = accManager.user?.name ?? "No username"
            viewModel.email = accManager.user?.email ?? "No email"
        }
    }
}

#Preview {
    NavigationStack {
        ProfileSettingsView()
            .environment(AccountManager())
    }
}
