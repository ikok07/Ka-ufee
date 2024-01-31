//
//  ProductCardView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import iOS_Backend_SDK

struct ProductCardView: View {
    
    let product: BusinessProduct
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.photo) ?? URL(string: "https://")!) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50)
                    .clipShape(Circle())
            } placeholder: {
                ZStack {
                    Color.customSecondary
                    
                    Image(systemName: "photo")
                        .foregroundStyle(.tertiary)
                        .font(.title2)
                }
                .frame(width: 50)
                .clipShape(Circle())
            }
            .padding(.trailing, 10)
            
            CardMainView(title: product.name, description: product.description)
            
            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .padding(.trailing)
        }
    }
}

#Preview {
    ProductCardView(product: K.Template.businessProduct)
        .padding()
}
