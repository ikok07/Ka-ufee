//
//  DetailsPageFieldsView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI

struct DetailsPageFieldsView<Content: View>: View {
    
    @Environment(AccountManager.self) private var accManager
    
    @Binding var name: String
    @Binding var description: String
    @Binding var validation: [Bool]
    
    var detailsPageType: DetailsPageType = .business
    var listHeight: CGFloat = 200
    
    @ViewBuilder var aditionalFields: Content
    
    var body: some View {
        
        if accManager.user?.role != "business" {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Description:")
                            .font(.headline)
                        
                        Text(description.isEmpty ? "No description available" : description)
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                
                switch detailsPageType {
                case .business:
                    EmptyView()
                case .product(let price, let currency):
                    ProductUserDescriptionView(
                        price: price,
                        currency: currency
                    )
                }
            }
            .padding()
        } else {
            List {
                ListInputField(
                    label: "Name",
                    placeholder: "Business name",
                    text: $name,
                    validation: $validation[0]
                )
                .validationType(.general)
                
                ListInputField(
                   label: "Info",
                   placeholder: "Business description",
                   text: $description,
                   validation: $validation[1]
                )
                .fieldLineLimit(5, reservesSpace: true)
                .validationType(.general)
                
                self.aditionalFields
            }
            .listStyle(.plain)
            .padding(.top)
            .frame(height: self.listHeight)
        }
    }
}

#Preview {
    DetailsPageFieldsView(
        name: .constant("Test"),
        description: .constant("Test"),
        validation: .constant([]),
        detailsPageType: .product(price: .constant("23.99"), currency: .constant(.usd))
    ) {}
        .environment(BusinessDetailsMainView.ViewModel())
        .environment(AccountManager.shared)
}
