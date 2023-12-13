//
//  SetupSecondPage.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI

struct SetupSecondPage: View {
    
    @Environment(SetupManager.ViewModel.self) private var viewModel
    
    var body: some View {
        VStack {
            
            Text("Setup page 2")
            
            Button("Finish setup") {
                Task {
                    await viewModel.finishSetup()
                }
            }
        }
    }
}

#Preview {
    SetupSecondPage()
        .environment(SetupManager.ViewModel())
}
