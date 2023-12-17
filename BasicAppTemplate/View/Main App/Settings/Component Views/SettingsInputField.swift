//
//  SettingsInputField.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct SettingsInputField: View {
    
    
    let label: String
    let placeholder: String
    var isDisabled: Bool = false
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 35) {
            Text(label)
            
            TextField(placeholder, text: $text)
                .foregroundStyle(isDisabled ? Color(uiColor: .tertiaryLabel) : Color(uiColor: .label))
                .disabled(isDisabled)
        }
    }
}

#Preview {
    List {
        SettingsInputField(label: "Email", placeholder: "Your email", isDisabled: true, text: .constant("kokmarok@gmail.com"))
            .padding()
    }
}
