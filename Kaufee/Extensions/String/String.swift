//
//  String.swift
//  Käufee
//
//  Created by Kaloyan Petkov on 26.01.24.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
