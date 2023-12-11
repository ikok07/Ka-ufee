//
//  DefaultButton.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

struct DefaultButton: View {
    
    let text: String
    
    var icon: String? = nil
    var color: Color = .accentColor
    var textColor: Color = .white
    var textWeight: Font.Weight = .bold
    
    var isDisabled: Bool = false
    var isLoading: Bool = false
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action, label: {
                HStack {
                    Spacer()
                    if isLoading {
                        ProgressView()
                    } else {
                        if let icon {
                            Image(systemName: icon)
                        }
                        Text(text)
                            .foregroundStyle(textColor)
                            .fontWeight(textWeight)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            })
            .buttonStyle(.borderedProminent)
            .disabled(isDisabled || isLoading)
            .animation(.easeOut, value: isDisabled)
            .animation(.easeOut, value: isLoading)
        }
    }
}

#Preview {
    DefaultButton(text: "Button text") {
        
    }
        .padding()
}
