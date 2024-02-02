//
//  CustomerHomeView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct CustomerHomeView: View {
    
    @State private var viewModel = ViewModel()
    @Environment(AccountManager.self) private var accManager
    @Environment(NavigationManager.self) private var navManager
    
    var body: some View {
        VStack {
            if viewModel.loading {
                LoadingView()
            } else if viewModel.backendResults.isEmpty {
                ScrollView {
                    NoResultView(
                        icon: "building.2.fill",
                        headline: "No businesses found",
                        subheadline: "There are no results\nto show"
                    )
                }
            } else {
                List {
                    ForEach(viewModel.businessesToShow, id: \.self) { business in
                        let businessIndex = viewModel.businessesToShow.firstIndex(of: business)
                        
                        Button {
                            if let businessIndex {
                                navManager.navigate(
                                    to: .BusinessDetails(business: .init(wrappedValue: $viewModel.businessesToShow[businessIndex])), path: .home
                                )
                            }
                        } label: {
                            BusinessCardView(
                                image: business.photo,
                                title: business.name,
                                description: business.description
                            )
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Search businesses")
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search businesses"))
        .animation(.default, value: viewModel.businessesToShow)
        .onAppear {
            Task {
                if !accManager.userLoaded {
                    await accManager.reloadUser()
                    
                    await viewModel.getAllBusinesses(
                        token: accManager.user?.token
                    )
                }
                viewModel.loading = false
            }
        }
        .onChange(of: viewModel.searchText, { oldValue, newValue in
            viewModel.filterBackendResults()
        })
        .refreshable {
            await Task {
                await accManager.reloadUser()
                await viewModel.getAllBusinesses(
                    token: accManager.user?.token
                )
            }.value
        }
    }
}

#Preview {
    NavigationStack {
        CustomerHomeView()
            .environment(AccountManager.shared)
            .environment(NavigationManager.shared)
    }
}
