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
    @State private var createNewItem = false
    @State var currentSelection: Int? = nil
    
    var body: some View {
        List {
            ForEach(dataManager.cylinders) { cylinder in
                NavigationLink(destination: CylinderDetailsView(cylinder: cylinder)
                    .environmentObject(dataManager)) {
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
            guard details.count == 3 else { return }

            let cylinder = Cylinder(id: UUID(uuidString: details[0]) ?? UUID(), date: Date.now, name: details[1], maxCapacity: Double(details[2]) ?? 1)
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
