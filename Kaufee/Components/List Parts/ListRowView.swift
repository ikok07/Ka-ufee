//
//  ListRowView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import SwiftUI

struct ListRowView<Content: View>: View {
    
    let label: String
    
    var labelWidth: CGFloat = 50
    var textColor: Color = Color.label
    
    @ViewBuilder let content: Content
    
    var body: some View {
        HStack(spacing: 25) {
            Text(label)
                .foregroundStyle(textColor)
                .frame(width: labelWidth)

            content
        }
    }
}

#Preview {
    ListRowView(label: "Test", content: {})
}
