//
//  ProfileSettingsUserView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct ProfileSettingsUserView: View {
    
    let imageUrl: String
    let name: String
    let email: String
    var localImage: UIImage? = nil
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if let localImage {
                    Image(uiImage: localImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                } else {
                    AsyncImage(url: URL(string: "\(K.App.assetServerUrl)\(imageUrl)")!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "person.crop.circle")
                            .foregroundStyle(.customSecondary)
                            .font(.system(size: 75))
                            .frame(width: 75)
                            .clipped(antialiased: true)
                    }
                }
                Spacer()
            }
            .padding(.bottom, 1)
            
            Text(self.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(self.email)
                .foregroundStyle(.gray)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .listRowBackground(Color.clear)
    }
}

#Preview {
    ProfileSettingsUserView(imageUrl: "https://", name: "John Smith", email: "kokmarok@gmail.com")
}
