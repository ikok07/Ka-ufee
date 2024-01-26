//
//  CreateBusinessView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct CreateBusinessView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List {
                
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 10) {
                            Image(systemName: "photo")
                                .foregroundStyle(.customSecondary)
                                .font(.system(size: 48))
                            
                            Text("Upload image of\nyour business")
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                }
                
                Section {
                    ListInputField(
                                   label: "Name",
                                   placeholder: "Business name",
                                   text: $viewModel.name,
                                   validation: .constant(false)
                    )
                    
                    ListInputField(
                                   label: "Info",
                                   placeholder: "Business description",
                                   text: $viewModel.description,
                                   validation: .constant(false)
                    )
                    .fieldLineLimit(5, reservesSpace: true)
                }
                
            }
        }
        .navigationTitle("New business")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Create") {
                    
                }
                .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateBusinessView()
    }
}
