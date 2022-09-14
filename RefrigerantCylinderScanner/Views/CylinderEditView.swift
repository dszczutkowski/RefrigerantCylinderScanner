//
//  CylinderEditView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 06/08/2022.
//

import SwiftUI

struct CylinderEditView: View {
    @EnvironmentObject var dataManager: DataManager
    var cylinder: Cylinder
    
    private var capacityArray = [10.0, 11.7, 25.0]
    @State private var selectedCapacity = 0
    @State private var contentTaken = 0.0
    @State private var contentRemaining = 10.0
    @State private var localisation = "Unknown"
    
    init(cylinder: Cylinder) {
        self.cylinder = cylinder
    }
    
    var body: some View {
        Form {
            Section(header: Text("Localisation")) {
                TextField("Your localisation", text: $localisation)
            }
            
            Section(header: Text("Capacity")) {
                Picker(selection: $selectedCapacity, label: EmptyView()) {
                    ForEach(0 ..< 3) {
                        Text("\(self.capacityArray[$0], specifier: "%.1f") L")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section() {
                Stepper(value: $contentTaken, in: 0...capacityArray[selectedCapacity], step: 0.01) {
                    Text("Content taken: \(contentTaken, specifier: "%.2f") litres")
                        .onChange(of: selectedCapacity, perform: { value in
                            contentTaken = min(capacityArray[value], contentTaken)
                            contentRemaining = capacityArray[value] - contentTaken
                        })
                }
                Slider(value: $contentTaken, in: 0...capacityArray[selectedCapacity])
                
                Text("\(contentRemaining, specifier: "%.2f") litres left")
                    .onChange(of: contentTaken, perform: { value in
                        contentRemaining = capacityArray[selectedCapacity] - value
                    })
            }
            
//            Section(header: Text("Last scanned")) {
//                Text("\(cylinder.lastScanned)")
//            }
        }
        .navigationTitle("\(cylinder.name)")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let roundContentTaken = Double(round(100*contentTaken)/100)
                    let newCylinder = Cylinder(id: cylinder.id, maxCapacity: capacityArray[selectedCapacity], contentRemaining: contentRemaining)
                    dataManager.add(newCylinder)
                    dataManager.saveScanHistory(data: newCylinder, contentTaken: roundContentTaken)
                    dataManager.updateCapacity(documentName: newCylinder.name, capacity: newCylinder.contentRemaining)
                    dataManager.fetchCylinders()
                }
            }
        }
    }
}

struct CylinderEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CylinderEditView(cylinder: Cylinder.sampleData[0])
        }
    }
}
