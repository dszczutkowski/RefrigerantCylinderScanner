//
//  DataManager.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 18/07/2022.
//

import Firebase
import SwiftUI
import CoreLocation

class DataManager: ObservableObject {
    @Published var cylinders: [Cylinder] = []
    let saveKey = "Cylinders"
    let db = Firestore.firestore()
    var tmpCylinder: Cylinder
    
    init () {
        tmpCylinder = Cylinder(id: 0102030405)
        fetchCylinders()
    }
    
    func fetchCylinders() {
        cylinders.removeAll()
        let ref = db.collection("Cylinders")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["name"] as? String ?? ""
                    let maxCap = data["maxCapacity"] as? Double ?? 0
                    let cntRem = data["contentRemaining"] as? Double ?? 0
                    
                    let cylinder = Cylinder(id: UInt(id) ?? 010101, maxCapacity: maxCap, contentRemaining: cntRem)
                    self.cylinders.append(cylinder)
                }
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(cylinders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func saveTmpCylinder(cylinder: Cylinder) {
        tmpCylinder = cylinder
    }
    
    func add(_ cylinder: Cylinder) {
        if(cylinders.contains(where: { $0.name == cylinder.name })) {
            cylinders.removeAll(where: { $0.name == cylinder.name })
        }
        cylinders.append(cylinder)
        save()
        writeCylinderToDb(data: Cylinder(id: cylinder.id, maxCapacity: cylinder.maxCapacity, contentRemaining: cylinder.contentRemaining))
    }
    
    func writeCylinderToDb(data: Cylinder) {
        let ref = db.collection("Cylinders")
        let dataTable = [
        "id" : "\(data.id)",
        "name" : data.name,
        "maxCapacity" : data.maxCapacity,
        "contentRemaining" : data.contentRemaining
        ] as [String : Any]
        
        ref.document("\(data.id)").setData(dataTable)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func saveScanHistory(data: Cylinder, contentTaken: Double) {
        let ref = db.collection("Cylinders")
        let history = History(contentTaken: contentTaken, localisation: getLocalisation())
        ref.document("\(data.name)").collection("ScanHistory").addDocument(data: [
            "date" : history.date,
            "localisation" : history.localisation,
            "contentTaken" : history.contentTaken
        ])
    }
    
    func updateCapacity(documentName: String, capacity: Double) {
        db.collection("Cylinders").document(documentName).updateData([
            "contentRemaining" : capacity
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated!")
            }
        }
    }
    
    func getLocalisation() -> String {
        var formatedAdress = ""
        var coordinate = CLLocationCoordinate2D()
        
        LocationManager.shared.getUserLocation { location in
            coordinate = location.coordinate
        }
        LocationManager.shared.lookUpCurrentLocation { placemark in
            formatedAdress = placemark?.postalAddressFormatted ?? "none"
        }
        
        return formatedAdress
    }
}
