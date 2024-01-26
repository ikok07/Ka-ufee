//
//  ListToggleRowView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 12.01.24.
//

import SwiftUI

struct ListToggleRowView: View {
    
    let label: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Toggle("", isOn: $isOn)
        }
    }
}

#Preview {
    ListToggleRowView(label: "Test", isOn: .constant(false))
        .padding()
}
