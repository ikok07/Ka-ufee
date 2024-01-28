//
//  CreateBusinessEmptyImageFieldView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 28.01.24.
//

import SwiftUI

struct CreateBusinessEmptyImageFieldView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 10) {
                Image(systemName: "photo")
                    .foregroundStyle(.customSecondary)
                    .font(.system(size: 48))
                
                Text("Click to upload image\nof your business")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

#Preview {
    CreateBusinessEmptyImageFieldView()
        
}
