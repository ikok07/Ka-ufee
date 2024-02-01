//
//  PlainTextField.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI

struct PlainTextField: View {
    
    @FocusState private var focusState
    @StateObject var viewModel: TextFieldViewModel = TextFieldViewModel()
    
    let placeholder: String
    
    var keyboardType: UIKeyboardType = .default
    var autoCapitalisation: Bool = true
    var secureField: Bool = false
    var validationType: TextFieldValidationType = .none
    var mainPassword: String? = nil
    
    @Binding var text: String
    @Binding var validation: Bool
    @Binding var error: (isAvailable: Bool, text: String)
    
    func validationType(_ type: TextFieldValidationType, mainPassword: String? = nil) -> PlainTextField {
        var view = self
        view.validationType = type
        if type == .password || type == .confirmPassword { view.secureField = true }
        if let mainPassword {
            view.mainPassword = mainPassword
        }
        return view
    }
    
    // It also disabled auto capitalisation
    func isSecure() -> PlainTextField {
        var view = self
        view.secureField = true
        view.autoCapitalisation = false
        return view
    }
    
    func disableCapitalisation() -> PlainTextField {
        var view = self
        view.autoCapitalisation = false
        return view
    }
    
    func keyboardType(_ type: UIKeyboardType) -> PlainTextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    var body: some View {
        ZStack {
            if !self.secureField {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .focused($focusState)
                    .textInputAutocapitalization(autoCapitalisation ? .sentences : .never)
            } else {
                SecureField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .focused($focusState)
                    .textInputAutocapitalization(autoCapitalisation ? .sentences : .never)
            }
        }
        .animation(.easeIn, value: focusState)
        .animation(.bouncy, value: viewModel.textFieldError.isAvailable)
        .animation(.bouncy, value: viewModel.textFieldError.text)
        .onAppear {
            viewModel.validationType = self.validationType
        }
        .onChange(of: self.text) { _, newText in
            self.text = self.text.replacingOccurrences(of: ",", with: ".")
            viewModel.validate(text: newText, mainPassword: self.mainPassword)
            validation = !viewModel.textFieldError.isAvailable
        }
        .onChange(of: viewModel.textFieldError.isAvailable) { _, _ in
            self.error = viewModel.textFieldError
        }
    }
}

#Preview {
    PlainTextField(placeholder: "", text: .constant(""), validation: .constant(false), error: .constant((false, "")))
}
