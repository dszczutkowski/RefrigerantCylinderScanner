//
//  Cylinder.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import Foundation

struct Cylinder: Identifiable {
    let id: UUID
    var date: Date
    let name: String
    
    init(id: UUID = UUID(), date: Date = Date(timeIntervalSinceNow: 0), name: String) {
        self.id = id
        self.date = date
        self.name = name
    }
}
