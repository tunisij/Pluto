//
//  File.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Team {
    
    var identifier: Int
    var name: String
    var users: Users
    var record: Record
    
    init(identifier: Int, name: String, users: Users, record: Record) {
        self.identifier = identifier
        self.name = name
        self.users = users
        self.record = record
    }
    
}

typealias Teams = [Team]