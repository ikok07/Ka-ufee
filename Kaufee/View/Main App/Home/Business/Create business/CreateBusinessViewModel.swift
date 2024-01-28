//
//  CreateBusinessViewModel.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI
import iOS_Backend_SDK

extension CreateBusinessView {
    
    @Observable final class ViewModel {
        
        var image: Image?
        var name: String = .init()
        var description: String = .init()
        
        var validations: [Bool] = Array(repeating: false, count: 2)
        
        func createButtonActive() -> Bool {
            return validations == Array(repeating: true, count: 2)
        }
        
        func createBusiness(token: String?, onSuccess completion: (CreateBusinessResponse) -> Void) async {
            await Backend.shared.createBusiness(image: self.image, name: self.name, description: self.description, token: token ?? "") { result in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                }
            }
        }
        
    }
    
}
