//
//  EquatableBinding.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI

public typealias EquatableAndHashable = Equatable & Hashable

@propertyWrapper
public struct EquatableBinding<Wrapped: EquatableAndHashable>: Equatable, Hashable {
   public var wrappedValue: Binding<Wrapped>

   public init(wrappedValue: Binding<Wrapped>) {
      self.wrappedValue = wrappedValue
   }

   public static func == (left: EquatableBinding<Wrapped>, right: EquatableBinding<Wrapped>) -> Bool {
      left.wrappedValue.wrappedValue == right.wrappedValue.wrappedValue
   }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue.wrappedValue)
    }
}
