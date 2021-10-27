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
        dataDictionary[Constants.FirebaseKeys.name] = name
        dataDictionary[Constants.FirebaseKeys.username] = username
        ref.child(Constants.FirebaseKeys.users).child(user.uid).setValue(dataDictionary)
    }
    
    func getName(completion: @escaping (_ name: String?) -> Void) {
        ref.child("\(Constants.FirebaseKeys.users)/\(getCurrentUser()!.uid)/\(Constants.FirebaseKeys.name)").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let name = snapshot.value as? String ?? "Unknown";
            completion(name)
        }
    }
    
    func getUsername(completion: @escaping (_ username: String) -> Void) {
        ref.child("\(Constants.FirebaseKeys.users)/\(getCurrentUser()!.uid)/\(Constants.FirebaseKeys.username)").getData { error, snapshot in
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
    
    func createGroup() -> String? {
        let groupRef = ref.child(Constants.FirebaseKeys.users).child(self.getCurrentUser()!.uid).child(Constants.FirebaseKeys.myGroups).childByAutoId()
        let key = groupRef.key
        guard let groupKey = key else { return nil }
        groupRef.setValue([Constants.FirebaseKeys.autoID: groupKey])
        groupRef.child(Constants.FirebaseKeys.members).childByAutoId().setValue(getCurrentUser()!.uid)
        return groupKey
    }
    
    func findUserID(from username: String, completion: @escaping (_ id: String?) -> Void) {
        ref.child(Constants.FirebaseKeys.users).queryOrdered(byChild: Constants.FirebaseKeys.username).queryStarting(atValue: username).queryEnding(atValue: username+"\u{f8ff}").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let id = value.keys.first
            completion(id)
        })
    }
    
    func addFriendToGroup(username: String, groupID: String, completion: @escaping (_ success: Bool) -> Void) {
        findUserID(from: username) { [weak self] uid in
            guard let `self` = self, let uid = uid else {
                completion(false)
                return
            }
            // Add friend to current user's group
            self.ref.child(Constants.FirebaseKeys.users).child(self.getCurrentUser()!.uid).child(Constants.FirebaseKeys.myGroups).child(groupID).child(Constants.FirebaseKeys.members).childByAutoId().setValue(uid)
            // Add group to friend's list of groups
            self.ref.child(Constants.FirebaseKeys.users).child(uid).child(Constants.FirebaseKeys.groups).child(groupID).setValue([Constants.FirebaseKeys.creator: self.getCurrentUser()!.uid])
            completion(true)
        }
    }
    
    func getMyGroups(completion: @escaping (_ groups: [Group]) -> Void) {
        var groups = [Group]()
        ref.child("\(Constants.FirebaseKeys.users)/\(getCurrentUser()!.uid)/\(Constants.FirebaseKeys.myGroups)").getData { [weak self] error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                print("couldn't cast value to [string: any]")
                return
            }
            for (_, value) in snapshotValue {
                guard let group = value as? [String: Any] else { return }
                guard let autoID = group[Constants.FirebaseKeys.autoID] as? String, let members = group[Constants.FirebaseKeys.members] as? [String: Any] else {
                    print("couldn't cast autoID to string or members to [string: any]")
                    return
                }
                var memberIDs = [String]()
                for (_, id) in members {
                    memberIDs.append("\(id)")
                }
                let newGroup = Group(groupID: autoID, creator: (self?.getCurrentUser()!.uid)!, members: memberIDs)
                groups.append(newGroup)
            }
            completion(groups)
        }
    }
    
    func getJoinedGroups(completion: @escaping (_ groups: [Group]) -> Void) {
        var groups = [Group]()
        ref.child("\(Constants.FirebaseKeys.users)/\(self.getCurrentUser()!.uid)/\(Constants.FirebaseKeys.groups)").getData { [weak self] error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let `self` = self, let snapshotValue = snapshot.value as? [String: Any] else {
                print("couldn't cast value to [string: any]")
                return
            }
            for (key, value) in snapshotValue {
                guard let group = value as? [String: Any], let creator = group[Constants.FirebaseKeys.creator] as? String else { return }
                let newGroup = Group(groupID: key, creator: creator, members: [creator, self.getCurrentUser()!.uid])
                groups.append(newGroup)
            }
            completion(groups)
        }
    }
}
