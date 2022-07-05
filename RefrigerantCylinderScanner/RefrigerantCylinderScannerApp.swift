//
//  RefrigerantCylinderScannerApp.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import SwiftUI

@main
struct RefrigerantCylinderScannerApp: App {
    var body: some Scene {
        WindowGroup {
            CylinderDetailsView(cylinder: Cylinder.sampleData[0])
        }
    }
}
