//
//  CylinderView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 07/07/2022.
//

import SwiftUI

struct CylinderView: View {
    let cylinder: Cylinder
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cylinder.name)
                .font(.title2)
            Spacer()
            HStack {
                Label("\(Int(cylinder.maxCapacity)) litres", systemImage: "fuelpump")
                Spacer()
                Label("\(cylinder.percentLeft()) left", systemImage: "gauge")
            }
        }
        .background(.gray)
    }
}

struct CylinderView_Previews: PreviewProvider {
    static var previews: some View {
        CylinderView(cylinder: Cylinder.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
