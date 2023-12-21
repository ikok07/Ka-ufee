//
//  ProfileSettingsViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI
import Observation
import PhotosUI
import iOS_Backend_SDK

extension ProfileSettingsView {
    
    @Observable final class ViewModel {
        
        var image: UIImage?
        var email: String = .init()
        var name: String = .init()
        
        var validation: [Bool] = Array(repeating: true, count: 2)
        var isLoading: Bool = false
        
        func saveButtonActive() -> Bool {
            if let user = Account.shared.accManager?.user {
                if !isLoading {
                    return (user.name != self.name || image != nil) && validation == Array(repeating: true, count: 2)
                } else {
                    return !isLoading
                }
            } else {
                return false
            }
        }
        #error("User photo is not updating in the API")
        
        @MainActor func saveDetails() async {
            if let user = Account.shared.accManager?.user {
                self.isLoading = true
                do {
                    try await saveFormData(user: user)
                    // add normal request
                    
                    self.image = nil
                    Components.shared.showMessage(type: .success, text: "Settings successfully saved")
                } catch {
                    if let error = error as? BackendError<String> {
                        Components.shared.showMessage(type: .error, text: error.localizedDescription)
                    }
                }
                self.isLoading = false
            } else {
                Components.shared.showMessage(type: .error, text: CustomError.NoUserAvailable.rawValue)
            }
        }
        
        func convertImageItem(_ item: PhotosPickerItem?) async {
            if let item, let itemData = try? await item.loadTransferable(type: Data.self) {
                self.image = .init(data: itemData)
            } else {
                Components.shared.showMessage(type: .error, text: "Image cannot be used")
            }
        }
        
        @MainActor private func saveFormData(user: User?) async throws {
            if let user {
                var requestError: BackendError<String>?
                await Backend.shared.updateNamePhoto(name: self.name, image: self.image, authToken: user.token ?? "") { result in
                    switch result {
                    case .success(let response):
                        DB.shared.update {
                            let newUser = user.thaw()
                            if let newUser {
                                newUser.name = response.data?.user?.name ?? "No username"
                                newUser.photo = response.data?.user?.photo ?? ""
                            } else {
                                requestError = BackendError(type: .CannotSaveUserDetails, localizedDescription: CustomError.NoUserAvailable.rawValue)
                            }
                        }
                        return
                    case .failure(let error):
                        requestError = error
                    }
                }
                if let requestError { throw requestError }
            } else {
                Components.shared.showMessage(type: .error, text: CustomError.NoUserAvailable.rawValue)
            }
        }
        
    }
    
}
