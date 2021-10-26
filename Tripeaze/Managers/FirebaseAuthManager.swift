//
//  FirebaseAuthManager.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseAuthManager {
    
    //MARK: Properties
    var ref: DatabaseReference! = Database.database().reference()
    
    //MARK: Methods
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: User?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = authResult?.user {
                completionBlock(user)
            } else {
                completionBlock(nil)
            }
        }
    }
    
    func setNameAndUsername(for user: User, name: String, username: String) {
        var dataDictionary: [String: Any] = [:]
        dataDictionary["name"] = name
        dataDictionary["username"] = username
        ref.child("users").child(user.uid).setValue(dataDictionary)
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
}
