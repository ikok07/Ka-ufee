//
//  ListRowView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import SwiftUI

struct ListRowView<Content: View>: View {
    
    let label: String
    @ViewBuilder let content: Content
    
    var labelWidth: CGFloat = 50
    
    var body: some View {
        HStack(spacing: 25) {
            Text(label)
                .frame(width: labelWidth)

            content
        }
    }
}

#Preview {
    ListRowView(label: "Test", content: {})
}
