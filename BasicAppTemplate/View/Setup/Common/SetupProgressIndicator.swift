//
//  SetupProgressIndicator.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 16.12.23.
//

import SwiftUI

struct SetupProgressIndicator: View {
    
    let percentage: Double
    
    var body: some View {
        GeometryReader { geometry in
            let initialWidth = geometry.size.width * 0.1
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(.customLight)
                    .frame(height: 12)
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: initialWidth + ((geometry.size.width - initialWidth) * percentage), height: 12)
            }
        }
        .frame(height: 12)
        .padding(.horizontal)
        .animation(.easeInOut, value: self.percentage)
    }
}

#Preview {
    SetupProgressIndicator(percentage: 0)
        .padding()
}
