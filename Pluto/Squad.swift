//
//  Group.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Squad {
    
    var key: String
    var name: String
    var admins: Users
    var users: Users
    
    init(name: String, admins: Users, users: Users, key: String = "") {
        self.key = key
        self.name = name
        self.admins = admins
        self.users = users
    }
    
}

typealias Squads = [Squad]
