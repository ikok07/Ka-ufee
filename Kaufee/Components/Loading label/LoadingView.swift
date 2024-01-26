//
//  Loading.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct LoadingView: View {
    
    var text: String = "Loading..."
    
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
            
            Text(text)
                .fontWeight(.semibold)
                .padding(.leading, 10)
                .shimmering(bandSize: 2)
        }
    }
}

#Preview {
    LoadingView()
}
