//
//  CylinderListView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 07/07/2022.
//

import SwiftUI

struct CylinderListView: View {
    @EnvironmentObject var dataManager: DataManager
    
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
    }
}

struct CylinderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            //CylinderListView(cylinders: Cylinder.sampleData)
        }
    }
}
