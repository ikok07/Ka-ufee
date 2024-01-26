//
//  AurhenticationOpenEmailSheetView.swift
//  AppTemplate
//
//  Created by Kaloyan Petkov on 28.09.23.
//

import SwiftUI

struct AuthenticationOpenEmailSheetView: View {

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundStyle(.ultraThickMaterial)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Choose client")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    Spacer()
                    
                    Button("Close") {
                        dismiss()
                    }
                    .padding(.top, 3)
                }
                VStack(spacing: 10) {
                    AuthenticationOpenEmailRowView(image: "appleMail", headline: "Mail App", subHeadline: "Apple", client: .apple)
                        
                    
                    AuthenticationOpenEmailRowView(image: "gmail", headline: "Gmail", subHeadline: "Google", client: .gmail)
                        
                    
                    AuthenticationOpenEmailRowView(image: "outlook", headline: "Outlook", subHeadline: "Microsoft", client: .outlook)
                        
                }
            }
            .padding()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .background {
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthenticationOpenEmailSheetView()
    }
}
