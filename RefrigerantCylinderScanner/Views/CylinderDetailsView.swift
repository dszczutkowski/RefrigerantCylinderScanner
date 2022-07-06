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
    var cylinder: Cylinder
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(uiImage: generateQrCode(from: "\(cylinder.name)"))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .center)
                    Rectangle()
                        .frame(width: 70, height: 200, alignment: .center)
                        .overlay {
                            Rectangle()
                                .frame(width: 60, height: cylinder.contentRemaining/cylinder.maxCapacity*200, alignment: .bottom)
                                .foregroundColor(.green)
                            Text("\(Int(cylinder.contentRemaining/cylinder.maxCapacity*100))%")
                        }
                }
                .padding(16)
                Form {
                    Text(cylinder.name)
                        .textContentType(.name)
                        .font(.title)
                    Text("\(cylinder.date)")
                        .textContentType(.dateTime)
                        .font(.title2)
                    Text("\(NSString(format: "%.2f", cylinder.contentRemaining )) litres")
                    Text("\(Int(cylinder.maxCapacity)) litres")
                }
                .padding(8)
            }
        }
        .navigationTitle("\(cylinder.name) details")
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
            CylinderDetailsView(cylinder: Cylinder.sampleData[0])
        }
        .preferredColorScheme(.dark)
    }
}
