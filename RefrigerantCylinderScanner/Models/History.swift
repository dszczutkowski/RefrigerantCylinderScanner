//
//  History.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 02/08/2022.
//

import Foundation

struct History: Identifiable {
    let id: UUID
    let date: Date
    let contentTaken: Double
    var localisation: String
    
    init(contentTaken: Double, date: Date, localisation: String)
    {
        self.id = UUID()
        self.date = date
        self.contentTaken = contentTaken
        self.localisation = localisation
    }
}
