//
//  User.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String
    let surname: String
    let credentials: Credentials = Credentials()
    
    init(id: UUID = UUID(), name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
    }
}
