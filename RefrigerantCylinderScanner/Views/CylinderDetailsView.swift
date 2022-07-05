//
//  CylinderDetailsView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import SwiftUI

struct CylinderDetailsView: View {
    var cylinder: Cylinder
    
    var body: some View {
        NavigationView {
            HStack {
                Text("\(cylinder.date)")
                Text(cylinder.name)
                Text("\(cylinder.maxCapacity)")
                Text("\(cylinder.contentRemaining)")
            }
        }
    }
}

struct CylinderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CylinderDetailsView(cylinder: .sampleData[0])
        }
    }
}
