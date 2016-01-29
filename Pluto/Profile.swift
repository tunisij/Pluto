//
//  Profile.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Profile {
    
    var userId: Int
    var name: String
    var isPublic: Bool
    var record: Record
    
    init(userId: Int, name: String, isPublic: Bool, record: Record) {
        self.userId = userId
        self.name = name
        self.isPublic = isPublic
        self.record = record
    }
    
}

typealias Users = [Profile]