//
//  SettingsNavigationButton.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct SettingsNavigationButton: View {
    
    let icon: String
    let label: String
    let destination: NavigationDestination
    
    var body: some View {
        Button(action: { Navigator.main.navigate(to: self.destination, path: .settings) }, label: {
            HStack {
                Image(systemName: self.icon)
                    .foregroundStyle(Color.accentColor)
                    .font(.title2)
                    .frame(width: 30)
                Text(self.label)
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(uiColor: .tertiaryLabel))
            }
            .foregroundStyle(Color(uiColor: .darkText))
        })
        .padding(.vertical, 5)
    }
}

#Preview {
    SettingsNavigationButton(icon: "person.circle", label: "Profile settings", destination: .profileSetttings)
        .padding()
}
