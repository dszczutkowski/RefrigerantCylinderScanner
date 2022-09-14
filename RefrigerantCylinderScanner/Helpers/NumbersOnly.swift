//
//  NumbersOnly.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 26/07/2022.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
