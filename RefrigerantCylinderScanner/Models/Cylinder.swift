//
//  Cylinder.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import Foundation
import CoreLocation

struct Cylinder: Identifiable {
    let id: UInt
    let name: String
    let lastScanned: Date
    //let location: CLLocationCoordinate2D
    let maxCapacity: Double
    var contentRemaining: Double
    
    init(id: UInt, date: Date = Date(timeIntervalSinceNow: 0), maxCapacity: Double = 10.0, contentRemaining: Double = 0) {
        self.id = id
        self.name = "\(id)"
        self.lastScanned = date
        self.maxCapacity = maxCapacity != 0 ? maxCapacity : 10.0
        self.contentRemaining = contentRemaining > maxCapacity ? maxCapacity : contentRemaining
        
//        let locationHelper = LocationHelper()
//        locationHelper.requestLocation()
//        self.location = locationHelper.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    func percentLeft() -> String {
        if(self.maxCapacity == 0) { return "0%" }
        return "\(Int(self.contentRemaining/self.maxCapacity*100))%"
    }
}

extension Cylinder {
    struct Data {
        var name: String = ""
        var maxCapacity: Double = 12
        var contentRemaining: Double = 0
    }
    
    var data: Data {
        Data(name: name, maxCapacity: maxCapacity, contentRemaining: contentRemaining)
    }
    
    init(data: Data) {
        id = UInt()
        name = data.name
        lastScanned = Date.init(timeIntervalSinceNow: 0)
        maxCapacity = data.maxCapacity
        contentRemaining = data.contentRemaining > data.maxCapacity ? data.maxCapacity : data.contentRemaining
    }
}

extension Cylinder {
    static let sampleData: [Cylinder] =
    [
        Cylinder(id: 12341, maxCapacity: 10, contentRemaining: 8.23),
        Cylinder(id: 12345231, maxCapacity: 100, contentRemaining: 8.23),
        Cylinder(id: 555535, maxCapacity: 6, contentRemaining: 2),
        Cylinder(id: 951235124, maxCapacity: 12, contentRemaining: 24),
        Cylinder(id: 33236464, maxCapacity: 5),
        Cylinder(id: 6436363, maxCapacity: 69, contentRemaining: 33)
    ]
}
