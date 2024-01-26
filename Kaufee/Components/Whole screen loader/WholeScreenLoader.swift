//
//  WholeScreenLoader.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 21.01.24.
//

import SwiftUI
import Shimmer

struct WholeScreenLoader: View {
    var body: some View {
        ZStack {
            if UXComponents.shared.showWholeScreenLoader {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.ultraThinMaterial)
                        .ignoresSafeArea()
                    
                    LoadingView(text: UXComponents.shared.wholeScreenLoaderText)
                }
            }
        }
        .animation(.default, value: UXComponents.shared.showWholeScreenLoader)
    }
}

#Preview {
    WholeScreenLoader()
}
