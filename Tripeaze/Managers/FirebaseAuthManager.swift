//
//  FirebaseAuthManager.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation
import UIKit
import FirebaseAuth

class FirebaseAuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                print("Firebase auth error: \(error?.localizedDescription), \(error.debugDescription)")
                if let error = error as NSError? {
                    print(error)
                }
                completionBlock(false)
            }
        }
    }
}
