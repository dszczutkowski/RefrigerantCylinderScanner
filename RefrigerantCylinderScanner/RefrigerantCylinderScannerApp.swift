//
//  RefrigerantCylinderScannerApp.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import SwiftUI
import Firebase

@main
struct RefrigerantCylinderScannerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginPageView()
            }
        }
    }
}
