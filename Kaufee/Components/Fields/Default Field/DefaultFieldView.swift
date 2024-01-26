//
//  DefaultFieldView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct DefaultFieldView<Content: View>: View {
    
    var icon: String? = nil
    @ViewBuilder let content: Content
    
    var body: some View {
        HStack {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(.customSecondary)
                    .font(.title2)
                    .frame(width: 40)
            }
            
            content
        }
        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.customSecondary, lineWidth: 1)
        }
    }
}

#Preview {
    DefaultFieldView() {
        
    }
}
