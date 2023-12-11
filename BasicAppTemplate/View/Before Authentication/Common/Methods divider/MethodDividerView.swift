//
//  MethodDividerView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

struct MethodDividerView: View {
    var body: some View {
        HStack(spacing: 20) {
            Rectangle()
                .foregroundStyle(.customSecondary)
                .frame(height: 1)
            Text("Or".uppercased())
                .foregroundStyle(.customSecondary)
                .fontWeight(.bold)
            Rectangle()
                .foregroundStyle(.customSecondary)
                .frame(height: 1)
        }
    }
}

#Preview {
    MethodDividerView()
        .padding()
}
