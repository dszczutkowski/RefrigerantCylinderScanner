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
    
    var body: some View {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack {
                        Text("Last scanned")
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                            .padding(8)
                            .font(.caption)
                        Text("\(cylinder.lastScanned.formatted(date: .long, time: .standard))")
                            .textContentType(.dateTime)
                            .font(.title2)
                    }
                    VStack {
                        Text("Capacity")
                            .foregroundColor(.gray)
                            .textCase(.uppercase)
                            .padding(8)
                            .font(.caption)
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
                        
                        Text("\(NSString(format: "%.2f", cylinder.contentRemaining ))L left")
                            .font(.title)
                        Text("out of \(Int(cylinder.maxCapacity)) litres")
                            .font(.title3)
                        
                    }
                    
                }
                VStack {
                }
                .padding(12)
            Form {
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
            CylinderDetailsView(cylinder: Cylinder.sampleData[0])
        }
        .preferredColorScheme(.dark)
        .padding()
        .environmentObject(DataManager.init())
    }
}
