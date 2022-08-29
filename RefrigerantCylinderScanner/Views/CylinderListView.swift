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
    @State private var isShowingNewCylinder = false
    @State private var createNewItem = false
    @State var selection: String? = nil
    
    var body: some View {
        List {
            ForEach(dataManager.cylinders) { cylinder in
                NavigationLink(destination: CylinderDetailsView(cylinder: cylinder)
                    .environmentObject(dataManager), tag: "\(cylinder.id)", selection: $selection) {
                    CylinderView(cylinder: cylinder)
                }
                .listRowBackground(Color.gray)
            }
//            NavigationLink("EditView", destination: CylinderEditView(cylinder: dataManager.tmpCylinder).environmentObject(dataManager), tag: "old", selection: $selection)
//                .hidden()
//                .listRowBackground(Color(white: 0, opacity: 100))
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
            CodeScannerView(codeTypes: [.code128], simulatedData: "TEST-123", completion: handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string
            let cylinder = Cylinder(id: UInt(details)!)
            dataManager.saveTmpCylinder(cylinder: cylinder)
            selection = details
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
