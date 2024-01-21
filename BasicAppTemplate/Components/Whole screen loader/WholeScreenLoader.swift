//
//  WholeScreenLoader.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 21.01.24.
//

import SwiftUI
import Shimmer

struct WholeScreenLoader: View {
    var body: some View {
        if UXComponents.shared.showWholeScreenLoader {
            ZStack {
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    ProgressView()
                    
                    Text(UXComponents.shared.wholeScreenLoaderText)
                        .fontWeight(.semibold)
                        .padding(.leading, 10)
                        .shimmering(bandSize: 2)
                }
            }
        }
    }
}

#Preview {
    WholeScreenLoader()
}
