//
//  ListProgressView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 19.12.23.
//

import SwiftUI

struct ListProgressView: View {
    
    let isActive: Bool
    
    var body: some View {
        if isActive {
            HStack {
                Spacer()
                
                ProgressView()
                    
                Spacer()
            }
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    ListProgressView(isActive: true)
}
