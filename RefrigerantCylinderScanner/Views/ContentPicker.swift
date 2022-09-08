//
//  ContentPicker.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 08/09/2022.
//

import SwiftUI

struct ContentPicker: View {
    @EnvironmentObject var dataManager: DataManager
    let cylinder: Cylinder
    
    private var capacityArray = [10.0, 11.7, 25.0]
    @State private var contentTaken = 0.0
    @State private var contentRemaining = 10.0
    @State private var localisation = "Unknown"
    
    init(cylinder: Cylinder) {
        self.cylinder = cylinder
    }
    
    var body: some View {
        Form {
            Section() {
                Stepper(value: $contentTaken, in: 0...cylinder.maxCapacity, step: 0.01) {
                    Text("Content taken: \(contentTaken, specifier: "%.2f") litres")
                }
                Slider(value: $contentTaken, in: 0...cylinder.maxCapacity)
                
                Text("\(contentRemaining, specifier: "%.2f") litres left")
                    .onChange(of: contentTaken, perform: { value in
                        contentRemaining = cylinder.maxCapacity - value
                    })
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let roundContentTaken = Double(round(100*contentTaken)/100)
                        dataManager.add(cylinder)
                        dataManager.saveScanHistory(data: cylinder, contentTaken: roundContentTaken)
                        dataManager.updateCapacity(documentName: cylinder.name, capacity: contentRemaining)
                        dataManager.fetchCylinders()
                    }
                }
            }
        }
    }
}

//struct ContentPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentPicker(maxCapacity: 10)
//    }
//}
