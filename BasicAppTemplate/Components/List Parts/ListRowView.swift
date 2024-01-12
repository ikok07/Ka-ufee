//
//  ListRowView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import SwiftUI

struct ListRowView<Content: View>: View {
    
    let label: String
    @ViewBuilder let content: Content
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            content
        }
    }
}

#Preview {
    ListRowView(label: "Test", content: {})
}
