//
//  BusinessHomeView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct BusinessHomeView: View {
    
    @State private var viewModel = ViewModel()
    @State private var addBusinessActive: Bool = false
    
    @Environment(AccountManager.self) private var accManager
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.loading {
                LoadingView()
            } else if viewModel.userBusinesses.isEmpty {
                ScrollView {
                    NoResultView(
                        icon: "building.2.fill",
                        headline: "No businesses found",
                        subheadline: "You haven't added any\nbusiness yet"
                    )
                }
            } else {
                List {
                    ForEach(viewModel.userBusinesses, id: \.self) { business in
                        BusinessCardView(
                            image: business.photo,
                            title: business.name,
                            description: business.description
                        )
                    }
                    .onDelete(perform: { indexSet in
                        Task {
                            await viewModel.deleteBusiness(
                                at: indexSet,
                                authToken: AccountManager.shared.user?.token
                            )
                        }
                    })
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Your businesses")
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { self.addBusinessActive = true }, label: {
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
        .animation(.default, value: viewModel.userBusinesses)
        .sheet(isPresented: $addBusinessActive, content: {
            CreateBusinessView(businesses: $viewModel.userBusinesses)
                .presentationDetents([.height(550)])
        })
        .onAppear {
            Task {
                if !accManager.userLoaded {
                    await accManager.reloadUser()
                    
                    await viewModel.getAllBusinesses(
                        userId: accManager.user?._id.stringValue,
                        token: accManager.user?.token
                    )
                }
            }
        }
        .refreshable {
            await Task {
                await accManager.reloadUser()
                await viewModel.getAllBusinesses(
                    userId: accManager.user?._id.stringValue,
                    token: accManager.user?.token
                )
            }.value
        }

    }
}

#Preview {
    NavigationStack {
        BusinessHomeView()
            .environment(AccountManager.shared)
    }
}
