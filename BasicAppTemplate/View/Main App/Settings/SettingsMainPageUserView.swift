//
//  SettingsMainPageUserView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import SwiftUI

struct SettingsMainPageUserView: View {
    
    let imageUrl: String
    let username: String
    let email: String
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: imageUrl)!) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.crop.circle")
                    .foregroundStyle(.customSecondary)
                    .font(.system(size: 50))
                    .frame(width: 80)
                    .clipped(antialiased: true)
            }
            
            VStack(alignment: .leading) {
                Text(username)
                    .font(.headline)
                
                Text(email)
                    .tint(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        
    }
}

#Preview {
    SettingsMainPageUserView(imageUrl: "https://images.pexels.com/photos/1/pexels-photo-1172207.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", username: "John Smith", email: "kokmarok@gmail.com")
        .padding()
}
