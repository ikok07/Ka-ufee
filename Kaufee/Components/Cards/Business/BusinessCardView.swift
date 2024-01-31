//
//  BusinessCard.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct BusinessCardView: View {
    
    let image: String?
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: image ?? "https://")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } placeholder: {
                ZStack {
                    Color.customSecondary
                    
                    Image(systemName: "photo")
                        .foregroundStyle(.tertiary)
                        .font(.largeTitle)
                }
                .frame(width: 100, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                    
            }
            .padding(.trailing, 15)

            
            CardMainView(title: self.title, description: self.description)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .padding(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            Section {
                BusinessCardView(image: nil, title: "Business name", description: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing ")
     
                BusinessCardView(image: nil, title: "Business name", description: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing ")
            }
        }
        .listStyle(.plain)
        .navigationTitle("Cards")
    }
}
