//
//  CylinderDetailsView.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 05/07/2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CylinderDetailsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selection = 0
    @State private var contentRemaining: NumbersOnly = NumbersOnly()
    
    var cylinder: Cylinder
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
            VStack {
                HStack {
                    Image(uiImage: generateQrCode(from: "\(cylinder.id)\n\(cylinder.name)\n\(cylinder.maxCapacity)"))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 210, height: 210, alignment: .center)
                        .padding(8)
                    VStack {
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
                    }
                }
                .padding(12)
                Form {
                    Section(header: Text("Last scanned")) {
                        Text("\(cylinder.date)")
                            .textContentType(.dateTime)
                            .font(.title2)
                    }
                    Section(header: Text("Capacity")) {
                        TextField("\(NSString(format: "%.2f", cylinder.contentRemaining )) litres left", text: $contentRemaining.value)
                            .keyboardType(.decimalPad)
                        Text("out of \(Int(cylinder.maxCapacity)) litres")
                    
                }
            }
            .navigationTitle("\(cylinder.name) details")
            .toolbar {
                Button {
                    dataManager.updateCapacity(documentName: cylinder.name, capacity: Double(contentRemaining.value)!)
                } label: {
                    Text("Save")
                }
            }
        }
    }

    func generateQrCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct CylinderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CylinderDetailsView(cylinder: Cylinder.sampleData[5])
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}
