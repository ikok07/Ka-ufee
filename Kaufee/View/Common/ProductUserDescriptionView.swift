//
//  ProductUserDescriptionView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI

struct ProductUserDescriptionView: View {
    
    @Binding var price: String
    @Binding var currency: Currency
    
    var body: some View {
        HStack(spacing: 7) {
            VStack(alignment: .leading, spacing: 7) {
                Text("Price:")
                    .font(.headline)
                
                HStack(alignment: .bottom, spacing: 5) {
                    Text("\(String(format: "%.2f", Double(price) ?? "???"))")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(currency.rawValue.uppercased())
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                }
                
                DefaultButton(text: "Buy now", icon: "cart") {
                    
                }
                .padding(.top)
            }
            Spacer()
        }
    }
}

#Preview {
    ProductUserDescriptionView(price: .constant("23.99"), currency: .constant(.usd))
        .padding()
}
