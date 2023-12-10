//
//  TextFieldViewModel.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI
import Observation

@Observable class TextFieldViewModel {
    
    var validationType: TextFieldValidationType = .none
    
    var text: String = ""
    var textFieldError: (isAvailable: Bool, text: String) = (false, "")
    
    func validate() {
        switch validationType {
        case .none:
            return
        case .general:
            <#code#>
        case .email:
            <#code#>
        case .password:
            <#code#>
        }
    }
    
    func getMainColor(focusState: Bool) -> Color {
        if textFieldError.isAvailable {
            return .red
        } else if focusState {
            return Color.accentColor
        } else {
            return .customSecondary
        }
    }
    
}
