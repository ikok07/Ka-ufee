//
//  SetupManager.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 13.12.23.
//

import SwiftUI

struct SetupManager: View {
    
    @State var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.activePage {
            case 1:
                SetupFirstPage()
                    .environment(viewModel)
            default:
                SetupSecondPage()
                    .environment(viewModel)
            }
        }
    }
}

#Preview {
    SetupManager()
}
