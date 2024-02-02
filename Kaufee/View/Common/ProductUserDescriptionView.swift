//
//  ProductUserDescriptionView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI
import StripePaymentSheet

struct ProductUserDescriptionView: View {
    
    @State private var stripeManager = StripeManager.shared
    
    @Binding var price: String
    @Binding var currency: Currency
    
    @State private var showPaymentSheet: Bool = false
    @State private var paymentSheet: PaymentSheet?
    
    @State private var productPurchased: Bool = false
    
    var body: some View {
        HStack(spacing: 7) {
            VStack(alignment: .leading, spacing: 7) {
                Text("Price:")
                    .font(.headline)
                
                HStack(alignment: .bottom, spacing: 5) {
                    Text("\(String(format: "%.2f", Double(price) ?? "???"))")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(currency.rawValue.uppercased())
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                }
                
                ZStack {
                    if let paymentSheet {
                        if self.productPurchased {
                            DefaultButton(text: "Product purchased", icon: "checkmark.circle.fill", isDisabled: true, action: {})
                        } else {
                            DefaultButton(text: self.showPaymentSheet ? "Loading..." : "Buy now", icon: "cart") {
                                if !self.showPaymentSheet {
                                    self.showPaymentSheet = true
                                }
                            }
                            .paymentSheet(
                                isPresented: $showPaymentSheet,
                                paymentSheet: paymentSheet,
                                onCompletion: { paymentResult in
                                    switch paymentResult {
                                    case .completed:
                                        UXComponents.shared.showMsg(type: .success, text: "Product successfully purchased!")
                                        self.productPurchased = true
                                    case .failed(let error):
                                        UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
                                    case .canceled:
                                        UXComponents.shared.showMsg(type: .alert, text: "Payment canceled")
                                    }
                                }
                            )
                        }
                    } else {
                        DefaultButton(text: "", isLoading: true, action: {})
                    }
                }
                .padding(.top)
            }
            .animation(.default, value: stripeManager.paymentSheet == nil)
            .onAppear {
                Task {
                    await stripeManager.preparePaymentSheet(
                        price: Double(self.price) ?? 0,
                        currency: self.currency
                    )
                    self.paymentSheet = stripeManager.paymentSheet
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProductUserDescriptionView(price: .constant("23.99"), currency: .constant(.usd))
        .padding()
}
