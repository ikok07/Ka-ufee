//
//  ListCustomButton.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct ListCustomButton: View {
    
    var icon: String? = nil
    let label: String
    var hasChevron: Bool = false
    let action: () -> Void
    
    var padding: CGFloat = 5
    var iconFont: Font = .title2
    var iconColor: Color = Color.accentColor
    
    var textColor: Color = .label
    
    func buttonPadding(_ value: CGFloat) -> ListCustomButton {
        var view = self
        view.padding = value
        return view
    }
    
    func iconFont(_ font: Font) -> ListCustomButton {
        var view = self
        view.iconFont = font
        return view
    }
    
    func iconColor(_ color: Color) -> ListCustomButton {
        var view = self
        view.iconColor = color
        return view
    }
    
    func textColor(_ color: Color) -> ListCustomButton {
        var view = self
        view.textColor = color
        return view
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(iconFont)
                        .frame(width: 30)
                }
                
                Text(self.label)
                    .foregroundStyle(textColor)
                
                Spacer()
                if hasChevron {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(uiColor: .tertiaryLabel))
                }
            }
            .foregroundStyle(Color(uiColor: .darkText))
        })
        .padding(.vertical, padding)
        .buttonStyle(.borderless)
    }
}

#Preview {
    ListCustomButton(icon: "person.circle", label: "Profile settings") {}
        .padding()
}
