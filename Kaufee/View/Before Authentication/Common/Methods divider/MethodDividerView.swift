//
//  MethodDividerView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import SwiftUI

struct MethodDividerView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.customSecondary)
                .frame(height: 1)
            Text("Customers only".uppercased())
                .foregroundStyle(.customSecondary)
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(Color(uiColor: .systemBackground))
        }
    }
}

#Preview {
    MethodDividerView()
        .padding()
}
