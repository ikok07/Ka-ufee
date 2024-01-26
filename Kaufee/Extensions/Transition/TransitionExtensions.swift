//
//  TransitionExtensions.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

extension AnyTransition {
    
    static var customSlideToRight: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    }
    
    static var customSlideToLeft: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
    
}
