//
//  CoolantPickerView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 20/07/2022.
//

import SwiftUI

struct CoolantPickerView: View {
    @State var cylinder: Cylinder
    @State var integerValue: Double = 0
    @State var tenths: Double = 0
    @State var hundredths: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: UIScreen.main.bounds.width*0.8, height: 40, alignment: .center)
                .offset(x: 20, y: 138)
                .opacity(0.6)
            HStack(spacing: 0) {
                Picker(selection: self.$integerValue, label: Text("")) {
                    ForEach(0 ..< Int(cylinder.maxCapacity), id: \.self) {
                        Text("\($0)")
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                Picker(selection: self.$tenths, label: Text("")) {
                    ForEach(0..<10) {
                        Text(". \($0)")
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                Picker(selection: self.$hundredths, label: Text("")) {
                    ForEach(0..<10) {
                        Text("\($0)")
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/4, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                Text("Litres")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .frame(width: 18, height: 280)
                    .offset(x: 10)
            }
            .padding(10)
            
        }
        .foregroundColor(.white)
        .background(.gray)
        .opacity(0.8)
        .frame(height: 200)
    }
    
    func sum() -> Double {
        return integerValue + tenths/10 + hundredths/100
    }
}

struct CoolantPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CoolantPickerView(cylinder: Cylinder.sampleData[0])
            .previewLayout(.fixed(width: 300, height: 200))
    }
}

extension UIPickerView {
   open override var intrinsicContentSize: CGSize {
       return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)}
}
