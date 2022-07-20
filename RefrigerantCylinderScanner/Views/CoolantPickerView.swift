//
//  CoolantPickerView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 20/07/2022.
//

import SwiftUI

struct CoolantPickerView: View {
    @State var cylinder: Cylinder
    @State var first: Double = 0
    @State var second: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                Picker(selection: self.$first, label: Text("")) {
                    ForEach(0 ..< 30) {
                        Text("\($0)")
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                Picker(selection: self.$second, label: Text("")) {
                    ForEach(0 ..< 30) {
                        Text(", \($0)")
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                Text("Litr")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .offset(x: 10)
                Spacer()
            }
        }
    }
}

struct CoolantPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoolantPickerView(cylinder: Cylinder.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
