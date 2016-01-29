//
//  Group.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Group {
    
    var identifier: Int
    var name: String
    var admins: Users
    var users: Users
    
    init(identifier: Int, name: String, admins: Users, users: Users) {
        self.identifier = identifier
        self.name = name
        self.admins = admins
        self.users = users
    }
    
}

typealias Groups = [Group]
