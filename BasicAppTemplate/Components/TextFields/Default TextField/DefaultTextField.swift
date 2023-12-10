//
//  DefaultTextField.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI

struct DefaultTextField: View {
    
    @FocusState private var focusState: Bool
    
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(focusState ? Color.accentColor : .customSecondary)
                    .font(.title2)
                
                TextField(placeholder, text: $text)
                    .focused($focusState)
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(focusState ? Color.accentColor : .customSecondary, lineWidth: 1)
            }
            .animation(.easeIn, value: focusState)
            
            HStack {
                Text("Error text")
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7))
                    .background(Color(uiColor: .systemBackground))
                    .padding(.leading)
                    .padding(.bottom, 45)
                Spacer()
            }
        }
    }
}

#Preview {
    DefaultTextField(icon: "envelope.fill", placeholder: "Placeholder", text: .constant(""))
        .padding()
}
