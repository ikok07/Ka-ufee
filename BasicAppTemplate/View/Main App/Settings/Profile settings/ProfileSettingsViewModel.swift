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
        
        func saveDetails() async {
            
        }
        
        func convertImageItem(_ item: PhotosPickerItem?) async {
            if let item, let itemData = try? await item.loadTransferable(type: Data.self) {
                self.image = .init(data: itemData)
            } else {
                Components.shared.showMessage(type: .error, text: "Image cannot be used")
            }
        }
        
    }
    
}
