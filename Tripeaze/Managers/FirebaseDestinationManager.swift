//
//  FirebaseDestinationManager.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/26/21.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseDestinationManager {
    
    //MARK: Properties
    var ref: DatabaseReference! = Database.database().reference()
    let uid = FirebaseAuthManager().getCurrentUser()!.uid
    
    //MARK: Methods
    func createDestination(destination: Destination) {
        var dataDictionary: [String: Any] = [:]
        dataDictionary["name"] = destination.name
        dataDictionary["numVotes"] = destination.numVotes
        ref.child("destinations").child(uid).childByAutoId().setValue(dataDictionary)
    }
    
    func getDestinations(completion: @escaping (_ destinations: [Destination]) -> Void) {
        ref.child("destinations").child(uid).observe(.value, with: { snapshot in
            guard let values = snapshot.value as? [String: Any] else { return }
            
            var destinations = [Destination]()
            for (_, value) in values {
                guard let destination = value as? [String: Any],
                      let name = destination["name"] as? String,
                      let numVotes = destination["numVotes"] as? Int else { return }
                destinations.append(Destination(name, numVotes))
            }
            completion(destinations)
        })
    }
}
