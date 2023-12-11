//
//  SignInWithGoogleButton.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            Image(.googleLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 15)
            Text("Sign in with Google")
                .foregroundStyle(colorScheme == .dark ? .black : .gray)
                .font(.subheadline)
                .fontWeight(.medium)
            Spacer()
        }
        .frame(height: 40)
        .background(colorScheme == .dark ? .white : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .overlay {
            RoundedRectangle(cornerRadius: 7)
                .stroke(colorScheme == .light ? .customSecondary : .clear, lineWidth: 1)
        }
    }
}

#Preview {
    SignInWithGoogleButton()
        .padding()
}
