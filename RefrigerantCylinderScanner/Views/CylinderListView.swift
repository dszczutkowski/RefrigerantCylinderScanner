//
//  CylinderListView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 07/07/2022.
//

import SwiftUI
import CodeScanner

struct CylinderListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var isShowingScanner = false
    
    var body: some View {
        List {
            ForEach(dataManager.cylinders) { cylinder in
                NavigationLink(destination: CylinderDetailsView(cylinder: cylinder)) {
                    CylinderView(cylinder: cylinder)
                }
                .listRowBackground(Color.gray)
            }
        }
        .navigationTitle("Cylinder list")
        .foregroundColor(Color.black)
        .toolbar {
            Button {
                isShowingScanner = true
            } label: {
                Label("Scan", systemImage: "qrcode.viewfinder")
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "TEST-123\n100", completion: handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let data = Cylinder.Data(name: details[0], maxCapacity: Double(details[1])!, contentRemaining: Double(details[1])!)

            let cylinder = Cylinder(data: data)
            dataManager.add(cylinder)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct CylinderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            //CylinderListView(cylinders: Cylinder.sampleData)
        }
    }
}
