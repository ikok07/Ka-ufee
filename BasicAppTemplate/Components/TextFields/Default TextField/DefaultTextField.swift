//
//  DefaultTextField.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI

struct DefaultTextField: View {
    
    @StateObject var viewModel: TextFieldViewModel = TextFieldViewModel()
    
    @FocusState private var focusState: Bool
    
    @Binding var text: String
    
    let icon: String
    let placeholder: String
    
    var keyboardType: UIKeyboardType = .default
    var autoCapitalisation: Bool = true
    var secureField: Bool = false
    var validationType: TextFieldValidationType = .none
    
    var mainPassword: String? = nil
    
    @Binding var validation: Bool

    
    func validationType(_ type: TextFieldValidationType, mainPassword: String? = nil) -> DefaultTextField {
        var view = self
        view.validationType = type
        if type == .password || type == .confirmPassword { view.secureField = true }
        if let mainPassword {
            view.mainPassword = mainPassword
        }
        return view
    }
    
    // It also disabled auto capitalisation
    func isSecure() -> DefaultTextField {
        var view = self
        view.secureField = true
        view.autoCapitalisation = false
        return view
    }
    
    func disableCapitalisation() -> DefaultTextField {
        var view = self
        view.autoCapitalisation = false
        return view
    }
    
    func keyboardType(_ type: UIKeyboardType) -> DefaultTextField {
        var view = self
        view.keyboardType = type
        return view
    }
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(viewModel.getMainColor(focusState: self.focusState))
                    .font(.title2)
                    .frame(width: 40)
                
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
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(viewModel.getMainColor(focusState: self.focusState), lineWidth: 1)
            }
            .onChange(of: self.text) { _, newText in
                viewModel.validate(text: newText, mainPassword: self.mainPassword)
                validation = !viewModel.textFieldError.isAvailable
            }
                        
            HStack {
                Text(viewModel.textFieldError.text)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7))
                    .background(Color(uiColor: .systemBackground))
                    .padding(.leading)
                    .padding(.bottom, 45)
                    .opacity(viewModel.textFieldError.isAvailable ? 1 : 0)
                Spacer()
            }
        }
        .frame(maxHeight: 45)

        .animation(.easeIn, value: focusState)
        .animation(.bouncy, value: viewModel.textFieldError.isAvailable)
        .animation(.bouncy, value: viewModel.textFieldError.text)
        .onAppear {
            viewModel.validationType = self.validationType
        }
    }
}

#Preview {
    DefaultTextField(text: .constant(""), icon: "envelope.fill", placeholder: "Placeholder", validation: .constant(false))
        .padding()
}
