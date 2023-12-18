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
        
        func saveButtonActive(user: User?) -> Bool {
            if let user {
                return user.name != self.name || image != nil
            } else {
                return false
            }
        }
        
        func saveDetails(user: User?) async {
            if let user {
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
        
        private func saveFormData(user: User?) async throws {
            if let user {
                var requestError: BackendError<String>?
                await Backend.shared.updateNamePhoto(name: self.name, image: self.image, authToken: user.token ?? "") { result in
                    switch result {
                    case .success(let response):
                        await DB.shared.update {
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
