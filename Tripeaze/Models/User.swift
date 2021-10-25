//
//  User.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation

class User {
    
    //MARK: Properties
    let username: String
    let name: String
    
    //MARK: Init
    init(username: String, name: String) {
        self.username = username
        self.name = name
    }
    
    func createDestination(name: String) -> Destination {
        let destination = Destination(name: name)
        return destination
    }
    
    func voteForDestination(_ destination: Destination) {
        destination.numVotes += 1
    }
}
