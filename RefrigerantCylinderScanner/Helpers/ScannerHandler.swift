//
//  ScannerHandler.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 03/08/2022.
//

import Foundation
import CodeScanner

struct ScannerHandler {
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 3 else { return }

            //let cylinder = Cylinder(id: UUID(uuidString: details[0]) ?? UUID(), date: Date.now, name: details[1], maxCapacity: Double(details[2]) ?? 1)
            //dataManager.add(cylinder)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}
