//
//  OverlayAsyncImageView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI


struct OverlayAsyncImageView: View {
    
    let photoUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: photoUrl) ?? URL(string: "https://")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(height: 270)
                .clipped()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundStyle(.customLight)
                    .frame(height: 270)
                
                Image(systemName: "photo")
                    .foregroundStyle(.customSecondary)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    OverlayAsyncImageView(photoUrl: "https://")
}
