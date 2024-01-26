//
//  AuthenticationOpenEmailRowView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

struct AuthenticationOpenEmailRowView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let image: String
    let headline: String
    let subHeadline: String
    let client: EmailClient
    
    var body: some View {
        Button(action: client.openEmail, label: {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    Text(headline)
                        .font(.headline)
                    
                    Text(subHeadline)
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(colorScheme == .dark ? .customSecondary : .white)
            .clipShape(RoundedRectangle(cornerRadius: 7))
        })
        .foregroundStyle(Color(UIColor.label))
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.ultraThickMaterial)
        AuthenticationOpenEmailRowView(image: "appleMail", headline: "Mail App", subHeadline: "Apple", client: .apple)
            .padding()
    }
    .ignoresSafeArea(edges: [.bottom, .top])
        
}
