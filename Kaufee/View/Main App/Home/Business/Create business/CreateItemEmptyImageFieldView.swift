//
//  CreateitemEmptyImageFieldView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import SwiftUI

struct CreateItemEmptyImageFieldView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                Image(systemName: "photo")
                    .foregroundStyle(.customSecondary)
                    .font(.system(size: 48))
                
                Text(text)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

#Preview {
    CreateItemEmptyImageFieldView(text: "Click to upload image\nof your business")
        
}
