//
//  OverlayHeadingView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import iOS_Backend_SDK

struct OverlayHeadingView: View {
    
    let name: String
    let creationDate: Date
    
    var body: some View {
        let createdDate = self.creationDate.formatted(.dateTime.month(.wide).day().year())
        
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(self.name)
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "calendar")
                    Text("Created: \(createdDate)")
                }
                .foregroundStyle(.secondary)
                .font(.footnote)
            }
            Spacer()
        }
    }
}

#Preview {
    OverlayHeadingView(name: "Test", creationDate: .now)
        .padding()
}
