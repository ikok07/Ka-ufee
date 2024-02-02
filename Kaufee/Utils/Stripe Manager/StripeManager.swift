//
//  StripeManager.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI
import Observation
import StripePaymentSheet
import NetworkRequests

@Observable final class StripeManager {
    
    static let shared = StripeManager()
    private init() {}
    
    let checkoutUrl = "\(K.App.backendUrl)/en/api/v1/payments/payment-sheet"
    var paymentSheet: PaymentSheet?
    var paymentResult: PaymentSheetResult?
    
    func preparePaymentSheet(price: Double, currency: Currency) async {
        
        let request: Result<CreatePaymentSheetResponse, NetworkError> = await Request.post(
            url: self.checkoutUrl,
            body: CreatePaymentSheetRequest(price: price, currency: currency.rawValue)
        )
        
        switch request {
        case .success(let response):
            if let publishabelKey = response.publishableKey, let customerId = response.customer, let ephemeralKey = response.ephemeralKey, let clientSecret = response.paymentIntent {
                STPAPIClient.shared.publishableKey = publishabelKey
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "Käufer"
                configuration.customer = .init(id: customerId, ephemeralKeySecret: ephemeralKey)
                configuration.returnURL = "kaufee://stripe-redirect"
                
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
                }
            } else {
                UXComponents.shared.showMsg(type: .error, text: CustomError.couldNotConnectToAPI.localizedDescription)
            }
        case .failure(let error):
            UXComponents.shared.showMsg(type: .error, text: error.localizedDescription)
        }
        
        func onPaymentCompletion(result: PaymentSheetResult) {
            self.paymentResult = result
            NotificationCenter.default.post(name: NotificationNames.paymentCompleted, object: nil)
        }
        
    }
}
