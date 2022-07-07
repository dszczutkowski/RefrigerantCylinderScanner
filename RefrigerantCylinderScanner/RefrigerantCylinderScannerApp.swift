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
            CylinderListView(cylinders: Cylinder.sampleData)
        }
    }
}
