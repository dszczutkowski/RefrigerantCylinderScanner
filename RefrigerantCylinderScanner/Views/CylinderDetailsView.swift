//
//  CylinderDetailsView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import SwiftUI

struct CylinderDetailsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selection = 0
    @State private var contentRemaining: NumbersOnly = NumbersOnly()
    
    var cylinder: Cylinder
    private let qrGenerator = QrGenerator()
    
    var body: some View {
            VStack {
                HStack {
                    Section(header: Text("Capacity")) {
                        VStack {
                            TextField("\(NSString(format: "%.2f", cylinder.contentRemaining )) litres left", text: $contentRemaining.value)
                                .keyboardType(.decimalPad)
                            Text("out of \(Int(cylinder.maxCapacity)) litres")
                        }
                    }
                    
                    VStack {
                        Rectangle()
                            .frame(width: 48, height: 12, alignment: .top)
                            .cornerRadius(10)
                        Rectangle()
                            .frame(width: 70, height: 188, alignment: .center)
                            .overlay {
                                Rectangle()
                                    .frame(width: 56, height: cylinder.contentRemaining/cylinder.maxCapacity*170, alignment: .bottom)
                                    .foregroundColor(.cyan)
                                Text("\(cylinder.percentLeft())")
                                    .foregroundColor(.black)
                            }
                            .cornerRadius(15)
                    }
                }
                .padding(12)
            Form {
                Section(header: Text("Last scanned")) {
                    Text("\(cylinder.lastScanned)")
                        .textContentType(.dateTime)
                        .font(.title2)
                }
                Section(header: Text("Scan history")) {
                    List {
                        
                    }
                }
            }
            .navigationTitle("\(cylinder.name) details")
            .toolbar {
                NavigationLink(destination: CylinderEditView(cylinder: cylinder)
                    .environmentObject(dataManager)) {
                    Text("Edit")
                }
                
            }
        }
    }
}

struct CylinderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CylinderDetailsView(cylinder: Cylinder.sampleData[5])
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}
