//
//  ScanView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 30/08/2022.
//

import SwiftUI

struct ScanView: View {
    let scan: History
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(scan.date.formatted(date: .long, time: .standard))")
                .font(.title2)
            Spacer()
            HStack {
                Text("\(scan.contentTaken, specifier: "%.2f") litres taken")
                Spacer()
                Text("in \(scan.localisation)")
            }
        }
        .background(.gray)
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(scan: History(contentTaken: 0.69, date: Date.now, localisation: "chujewo"))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
