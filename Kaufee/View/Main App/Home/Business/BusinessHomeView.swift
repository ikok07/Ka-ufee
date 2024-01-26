//
//  BusinessHomeView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct BusinessHomeView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.loading {
                LoadingView()
            } else if viewModel.userBusinesses.isEmpty {
                NoResultView(
                    icon: "building.2.fill",
                    headline: "No businesses found",
                    subheadline: "You haven't added any\nbusiness yet"
                )
            } else {
                ForEach(viewModel.userBusinesses, id: \.self) { business in
                    BusinessCardView(
                        image: nil,
                        title: business.name,
                        description: business.description
                    )
                }
                Spacer()
            }
        }
        .navigationTitle("Your businesses")
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    HStack {
                        Text("Add")
                        Image(systemName: "plus")
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.init(top: 5, leading: 7, bottom: 5, trailing: 7))
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            Color(.listBackground)
                .ignoresSafeArea()
    
            BusinessHomeView()
        }
    }
}
