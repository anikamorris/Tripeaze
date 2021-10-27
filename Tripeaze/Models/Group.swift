//
//  Group.swift
//  Tripeaze
//
//  Created by Anika Morris on 10/27/21.
//

import Foundation

class Group {
    let groupID: String
    let creator: String
    var members = [String]()
    
    init(groupID: String, creator: String, members: [String] = []) {
        self.groupID = groupID
        self.creator = creator
        self.members = members
    }
}
