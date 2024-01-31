//
//  CardMainView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI

struct CardMainView: View {
    
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(Color.label)
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(description)
                .foregroundStyle(.gray)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .padding(.trailing, 30)
    }
}

#Preview {
    CardMainView(title: "Test", description: "Test")
}
