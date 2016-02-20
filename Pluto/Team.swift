//
//  File.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class Team {
    
    let key: String!
    let ref: Firebase?
    
    var name: String!
    var captainKey: String!
    var usersKey: String!
    var recordKey: String!
    
    init(name: String, captainKey: String, usersKey: String, recordKey: String, key: String = "") {
        self.key = key
        self.name = name
        self.captainKey = captainKey
        self.usersKey = usersKey
        self.recordKey = recordKey
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        name = snapshot.value["name"] as! String
        captainKey = snapshot.value["captainKey"] as! String
        usersKey = snapshot.value["usersKey"] as! String
        recordKey = snapshot.value["recordKey"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "captainKey": captainKey,
            "usersKey": usersKey,
            "recordKey": recordKey
        ]
    }
    
}

typealias Teams = [Team]