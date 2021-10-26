//
//  Destination.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/25/21.
//

import Foundation

class Destination {
    let name: String
    var numVotes: Int = 0
    
    init(_ name: String, _ numVotes: Int = 0) {
        self.name = name
    }
}
