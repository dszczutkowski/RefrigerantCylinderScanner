//
//  Cylinder.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import Foundation
import CoreLocation

struct Cylinder: Identifiable {
    let id: UUID
    var date: Date
    let name: String
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), date: Date = Date(timeIntervalSinceNow: 0), name: String) {
        self.id = id
        self.date = date
        self.name = name
        
        let locationHelper = LocationHelper()
        locationHelper.requestLocation()
        self.location = locationHelper.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}
