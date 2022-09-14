//
//  LoginController.swift
//  RefrigerantCylinderScanner
//
//  Created by Dave Szczutkowski on 03/08/2022.
//

import Foundation
import Firebase

class LoginController {
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func isUserLoggedIn() -> Bool {
        var isLogged = false
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                isLogged = true
            }
        }
        return isLogged
    }
}
