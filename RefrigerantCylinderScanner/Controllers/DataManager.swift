//
//  DataManager.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 18/07/2022.
//

import Firebase
import SwiftUI

class DataManager: ObservableObject {
    @Published var cylinders: [Cylinder] = []
    let saveKey = "Cylinders"
    let db = Firestore.firestore()
    
    init () {
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
                    
                    let date = data["date"] as? Date ?? Date.now
                    let name = data["name"] as? String ?? ""
                    let maxCap = data["maxCapacity"] as? Double ?? 0
                    let cntRem = data["contentRemaining"] as? Double ?? 0
                    
                    let cylinder = Cylinder(date: date, name: name, maxCapacity: maxCap, contentRemaining: cntRem)
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
    
    func add(_ cylinder: Cylinder) {
        if(cylinders.contains(where: { $0.name == cylinder.name })) {
            cylinders.removeAll(where: { $0.name == cylinder.name })
        }
        cylinders.append(cylinder)
        save()
        writeToDb(data: Cylinder(id: cylinder.id, name: cylinder.name, maxCapacity: cylinder.maxCapacity, contentRemaining: cylinder.contentRemaining))
    }
    
    func writeToDb(data: Cylinder) {
        let ref = db.collection("Cylinders")
        let dataTable = [
        "id" : "\(data.id)",
        "date" : data.date,
        "name" : data.name,
        "maxCapacity" : data.maxCapacity,
        "contentRemaining" : data.contentRemaining
        ] as [String : Any]
        
        ref.document("\(data.name)").setData(dataTable)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
