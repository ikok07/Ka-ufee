//
//  DetailsPageType.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 31.01.24.
//

import SwiftUI

enum DetailsPageType {
    case business
    case product(price: Binding<String>, currency: Binding<Currency>)
}
