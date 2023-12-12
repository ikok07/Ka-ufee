//
//  BeforeAuthHeadingView.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 9.12.23.
//

import SwiftUI

struct BeforeAuthHeadingView: View {
    
    let icon: String
    let heading: String
    let mainHeadingWord: String
    let subheadline: String
    
    var body: some View {
        VStack(spacing: 7) {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .font(.title)
                .frame(width: 50, height: 50)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .padding(.bottom, 5)
            
            Text("\(heading)\(Text(mainHeadingWord).foregroundStyle(Color.accentColor).fontWeight(.bold))")
                .font(.title2)
            
            Text(subheadline)
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    BeforeAuthHeadingView(icon: "building.columns.fill", heading: "Welcome to ", mainHeadingWord: "AppName", subheadline: "Login to continue")
}
