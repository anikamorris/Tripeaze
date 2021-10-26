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
    func createUser(email: String, password: String, completion: @escaping (_ user: User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = authResult?.user {
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func setNameAndUsername(for user: User, name: String, username: String) {
        var dataDictionary: [String: Any] = [:]
        dataDictionary["name"] = name
        dataDictionary["username"] = username
        ref.child("users").child(user.uid).setValue(dataDictionary)
    }
    
    func getName(completion: @escaping (_ name: String?) -> Void) {
        ref.child("users/\(getCurrentUser()!.uid)/name").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let name = snapshot.value as? String ?? "Unknown";
            completion(name)
        }
    }
    
    func getUsername(completion: @escaping (_ username: String) -> Void) {
        ref.child("users/\(getCurrentUser()!.uid)/username").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let username = snapshot.value as? String ?? "Unknown";
            completion(username)
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let resultError = error, let _ = AuthErrorCode(rawValue: resultError._code) {
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
    
    func findUserID(from username: String, completion: @escaping (_ id: String?) -> Void) {
        ref.child("users").queryOrdered(byChild: "username").queryStarting(atValue: username).queryEnding(atValue: username+"\u{f8ff}").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let id = value.keys.first
            completion(id)
        })
    }
    
    func addFriend(username: String, completion: @escaping (_ success: Bool) -> Void) {
        findUserID(from: username) { [weak self] uid in
            guard let `self` = self else { return }
            guard let uid = uid else {
                completion(false)
                return
            }
            self.ref.child("users").child(self.getCurrentUser()!.uid).child("friends").childByAutoId().setValue(uid)
            completion(true)
        }
    }
    
    func createGroup() -> String? {
        let groupRef = ref.child("groups").childByAutoId()
        let key = groupRef.key
        guard let groupKey = key else { return nil }
        groupRef.setValue(["autoId": groupKey])
        groupRef.child("members").childByAutoId().setValue(getCurrentUser()!.uid)
        return groupKey
    }
    
    func addFriendToGroup(friendID: String, groupID: String) {
        ref.child("groups").child(groupID).child("members").childByAutoId().setValue(friendID)
    }
    
    
}
