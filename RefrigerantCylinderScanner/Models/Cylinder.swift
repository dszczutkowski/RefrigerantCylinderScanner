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
    let maxCapacity: Double
    var contentRemaining: Double
    
    init(id: UUID = UUID(), date: Date = Date(timeIntervalSinceNow: 0), name: String, maxCapacity: Double, contentRemaining: Double = 0) {
        self.id = id
        self.date = date
        self.name = name
        self.maxCapacity = maxCapacity
        self.contentRemaining = contentRemaining > maxCapacity ? maxCapacity : contentRemaining
        
        let locationHelper = LocationHelper()
        locationHelper.requestLocation()
        self.location = locationHelper.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}

extension Cylinder {
    static let sampleData: [Cylinder] =
    [
        Cylinder(name: "GJZ_20553", maxCapacity: 12, contentRemaining: 8.23),
        Cylinder(name: "BRS_2022", maxCapacity: 100, contentRemaining: 8.23),
        Cylinder(name: "SPD_334343_3D3", maxCapacity: 6, contentRemaining: 2),
        Cylinder(name: "GJZ_542", maxCapacity: 12, contentRemaining: 24),
        Cylinder(name: "Kajtek", maxCapacity: 5)
    ]
}