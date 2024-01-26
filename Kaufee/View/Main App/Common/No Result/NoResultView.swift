//
//  NoResultView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct NoResultView: View {
    
    var icon: String? = nil
    var headline: String = "No results found"
    var subheadline: String = "We can't find item matching\nyour search"
    
    var body: some View {
        VStack(spacing: 10) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(.secondary)
                    .font(.system(size: 36))
            }
            
            VStack(spacing: 5) {
                Text(headline)
                    .foregroundStyle(Color.label)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subheadline)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
        .transition(.opacity)
    }
}

#Preview {
    NoResultView(icon: "globe")
}
