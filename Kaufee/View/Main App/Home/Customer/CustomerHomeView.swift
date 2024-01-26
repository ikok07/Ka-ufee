//
//  CustomerHomeView.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import SwiftUI

struct CustomerHomeView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search businesses"))
    }
}

#Preview {
    NavigationStack {
        CustomerHomeView()
    }
}
