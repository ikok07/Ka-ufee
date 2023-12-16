//
//  SetupFirstPage.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI
import RealmSwift

struct SetupFirstPage: View {
    
    @Environment(SetupManager.ViewModel.self) private var viewModel
    
    var body: some View {
        VStack {
            Text("Setup page 1")
            
            Button("Continue") {
                viewModel.activePage += 1
            }
        }
    }
}

#Preview {
    SetupFirstPage()
        .environment(SetupManager.ViewModel())
}
